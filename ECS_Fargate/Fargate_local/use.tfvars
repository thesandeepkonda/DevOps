    
project_name = "vanlavino"
environment = "dev"
aws_region = "ap-south-1"
    
# VPC
vpc_cidr = "10.0.0.0/16"

availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]

public_subnet_cidrs = [
  "10.0.0.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.3.0/24"
]

enable_nat_gateway = true
    
# ALB
    
# Example ACM certificate
certificate_arn = "arn:aws:acm:ap-south-1:592694688975:certificate/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

container_port = 8080

health_check_path = "/actuator/health"
    
# ECS Fargate
    

container_name = "vanlavino-backend"

task_cpu = 512
task_memory = 1024
desired_count = 1
min_capacity = 1
max_capacity = 2

    
# Docker / ECR
container_image = "592694688975.dkr.ecr.ap-south-1.amazonaws.com/vanlavino:v0.2.2"

    
# Application Environment Variables
    

environment_variables = {

  SPRING_JPA_HIBERNATE_DEFAULT_SCHEMA = "cafe"

  SPRING_JPA_HIBERNATE_DDL_AUTO = "update"

  SPRING_JPA_SHOW_SQL = "false"

  SPRING_SERVLET_MULTIPART_MAX_FILE_SIZE = "50MB"

  SPRING_SERVLET_MULTIPART_MAX_REQUEST_SIZE = "50MB"

  CLOUD_AWS_REGION_STATIC = "ap-south-1"

  CLOUD_AWS_S3_BUCKET_NAME = "vanlavino-images"

  APP_JWT_EXPIRATION = "345600000"

  APP_CORS_ALLOWED_ORIGINS = "https://cafe.anasolconsultancyservices.com,https://warehouse.vanlavino.in,https://backend.vanlavino.in,http://localhost:3000"

  APP_CORS_ALLOWED_METHODS = "GET,POST,PUT,DELETE,OPTIONS"

  APP_CORS_ALLOWED_HEADERS = "Authorization,Content-Type"

  APP_CORS_EXPOSED_HEADERS = "Authorization"

  APP_CORS_ALLOW_CREDENTIALS = "false"

  APP_CORS_MAX_AGE = "3600"
}


    
# GitHub Actions
    

github_repository = "YOUR-GITHUB-USERNAME/YOUR-REPOSITORY"

github_branch = "main"