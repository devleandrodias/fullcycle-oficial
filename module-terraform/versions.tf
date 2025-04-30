terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.96.0"
    }
  }
  backend "s3" {
    bucket  = "devleandrodias-fullcycle-terraform-state"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    profile = "devleandrodias"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "devleandrodias"
}
