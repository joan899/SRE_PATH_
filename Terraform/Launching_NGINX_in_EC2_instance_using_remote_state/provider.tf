terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraformchallenges"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my-table-dynamodb"
    encrypt        = true
  }

  required_version = ">= 1.2.0"
}


provider "aws" {
  region = var.aws_region  # Region that will be used to create resources in AWS
}

