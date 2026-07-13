variable "vpc_id" {}
variable "database_subnets" {}

resource "aws_security_group" "rds" {
  name        = "zufeto-rds-sg"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] 
  }
}

resource "aws_db_subnet_group" "rds" {
  name       = "zufeto-rds-subnet-group"
  subnet_ids = var.database_subnets
}

resource "aws_db_instance" "postgres" {
  identifier                  = "zufeto-db"
  engine                      = "postgres"
  engine_version              = "16"
  instance_class              = "db.t4g.micro"
  allocated_storage           = 20
  db_name                     = "zufeto"
  username                    = "zufeto_admin"
  manage_master_user_password = true
  db_subnet_group_name        = aws_db_subnet_group.rds.name
  vpc_security_group_ids      = [aws_security_group.rds.id]
  storage_encrypted           = true
  performance_insights_enabled = true
  backup_retention_period     = 7
  skip_final_snapshot         = true
}

output "db_endpoint" { value = aws_db_instance.postgres.endpoint }
