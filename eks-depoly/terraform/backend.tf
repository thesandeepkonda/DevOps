terraform {
  backend "s3" {
    bucket         = "zufeto-terraform-state-prod"
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "zufeto-terraform-locks"
  }
}
