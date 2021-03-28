//refer to remote backend which was terraformed with terraform/init folder
terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "terraform-state-todo-api"
    region = "eu-west-3"
    key = "terraform.tfstate"
  }
}

provider "aws" {
  region  = "eu-west-3"
  version = "3.34"
}

module "todo-api" {
  source = "./modules/todo-api"

  providers = {
    aws  = aws
  }
}