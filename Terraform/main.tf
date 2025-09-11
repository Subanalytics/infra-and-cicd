terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "tushar-terraform-state"     # must be globally unique
    key            = "env/tushar/terraform.tfstate"  
    region         = "us-east-1"                         
    dynamodb_table = "tushar-terraform-locks"     
    encrypt        = true                                
  }
}


provider "aws" {
  region = var.aws_region
}

