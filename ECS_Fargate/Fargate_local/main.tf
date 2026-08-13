# -------------------------------
# VPC
# -------------------------------
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "${var.project_name}-${var.environment}-vpc" }
}

# -------------------------------
# Internet Gateway
# -------------------------------
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "${var.project_name}-${var.environment}-igw" }
}

# -------------------------------
# Public Subnets
# -------------------------------
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.environment}-public-subnet-${count.index + 1}"
    Tier = "Public"
  }
}

# -------------------------------
# Private Subnets
# -------------------------------
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.project_name}-${var.environment}-private-subnet-${count.index + 1}"
    Tier = "Private"
  }
}

# -------------------------------
# Public Route Table & Association
# -------------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "${var.project_name}-${var.environment}-public-route-table" }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# -------------------------------
# NAT Gateway
# -------------------------------
resource "aws_eip" "nat" {
  count  = var.enable_nat_gateway ? 1 : 0
  domain = "vpc"
  tags = { Name = "${var.project_name}-${var.environment}-nat-eip" }
}

resource "aws_nat_gateway" "this" {
  count         = var.enable_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public[0].id
  depends_on    = [aws_internet_gateway.this]
  tags = { Name = "${var.project_name}-${var.environment}-nat-gateway" }
}

# -------------------------------
# Private Route Table & Association
# -------------------------------
resource "aws_route_table" "private" {
  count  = var.enable_nat_gateway ? 1 : 0
  vpc_id = aws_vpc.this.id
  tags = { Name = "${var.project_name}-${var.environment}-private-route-table" }
}

resource "aws_route" "private_nat" {
  count                  = var.enable_nat_gateway ? 1 : 0
  route_table_id         = aws_route_table.private[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[0].id
}

resource "aws_route_table_association" "private" {
  count          = var.enable_nat_gateway ? length(aws_subnet.private) : 0
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[0].id
}

# -------------------------------
# ALB Module Call
# -------------------------------
module "alb" {
  source = "github.com/thesandeepkonda/DevOps//modules/alb"
  
  # Corrected to match modules/alb/variables.tf
  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = aws_vpc.this.id
  public_subnet_ids = aws_subnet.public[*].id
  container_port    = var.container_port
  health_check_path = var.health_check_path
  certificate_arn   = var.certificate_arn
}

# -------------------------------
# ECS Fargate Module Call
# -------------------------------
module "ecs" {
  source = "github.com/thesandeepkonda/DevOps//modules/ecs"
  
  resource_name                 = "${var.project_name}-${var.environment}"
  aws_region                    = var.aws_region
  vpc_id                        = aws_vpc.this.id
  vpc_cidr                      = var.vpc_cidr
  subnet_ids                    = aws_subnet.private[*].id
  is_fargate                    = true
  task_role_managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
  exec_role_managed_policy_arns = ["arn:aws:iam::aws:policy/SecretsManagerReadWrite"]
  
  services = {
    "${var.project_name}" = {
      repo_name        = var.project_name
      image_tag        = lookup(var.image_tags, var.project_name, "v0.2.2")
      cpu              = var.task_cpu
      memory           = var.task_memory
      container_port   = var.container_port
      host_port        = var.container_port
      desired_count    = var.desired_count
      # Corrected to reference the output correctly
      target_group_arn = module.alb.target_group_arn 
      secrets          = {}
      environment      = var.environment_variables
      create_repo      = true
      
      autoscaling = {
        min_capacity = var.min_capacity
        max_capacity = var.max_capacity
        cpu_target   = 75
        mem_target   = 75
      }
    }
  }
}