terraform {
  # Run init/plan/apply with "backend" commented-out (uses local backend) to provision Resources (Bucket, Table)
  # Then uncomment "backend" and run init, apply after Resources have been created (uses AWS)
  backend "s3" {
    bucket         = "tfstate-backend-cicd-alois"
    key            = "tf-infra/terraform.tfstate"
    region         = "eu-south-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region = "eu-south-1"
}

module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = "tfstate-backend-cicd-alois"
}