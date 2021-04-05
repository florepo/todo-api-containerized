//used to initialize the remote backend for the environment
provider "aws" {
  region = "eu-west-3"
  version = "3.34"
}

resource "aws_s3_bucket" "terraform-state-backend" {
    bucket = "terraform-state-todo-api"
    acl    = "private"
    versioning {
      enabled = true
    }
    lifecycle {
      prevent_destroy = true
    } 
}