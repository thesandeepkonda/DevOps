terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.26.0"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
}
