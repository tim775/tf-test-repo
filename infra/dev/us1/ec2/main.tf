provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

resource "aws_instance" "web_app" {
  ami           = "ami-674cbc1e"
  instance_type = "t3.2xlarge"

  tags = {
    "bat"  = "ball"
    "fizz" = "buzz"
    "ef" = "rbd"
  }

  root_block_device {
    volume_size = 50
    tags = {
      "ef" = "rbd"
    }
  }
}

resource "aws_instance" "web_app_new" {
  ami           = "ami-674cbc1e"
  instance_type = "t3.4xlarge"

  tags = {
    "bat"  = "ball"
    "fizz" = "buzz"
    "ef" = "fe"
  }

  root_block_device {
    volume_size = 50
    tags = {
      "ef" = "rbd"
    }
  }
}

module "vpc" { 

  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = var.stage
  cidr = local.cidr
  azs  = local.azs

  // /24s starting at .0 and up to .16
  public_subnets = [for index, az in local.azs : cidrsubnet(local.cidr, 8, index)]
  // /20s starting at .16 and up to .112
  private_subnets = [for index, az in local.azs : cidrsubnet(local.cidr, 4, index + 1)]
  // /24s starting at .128
  database_subnets = [for index, az in local.azs : cidrsubnet(local.cidr, 8, index + 128)]

  public_subnet_tags   = { for tag in local.subnet_tags : tag => "Public" }
  private_subnet_tags  = { for tag in local.subnet_tags : tag => "Private" }
  database_subnet_tags = { for tag in local.subnet_tags : tag => "Isolated" }

  enable_nat_gateway     = true
  one_nat_gateway_per_az = false
  single_nat_gateway     = false
}

locals {
  azs  = [
      "us-west-2a",
      "us-west-2b",
      "us-west-2c"
    ]
  cidr = "10.174.0.0/16"
  // Subnet Tags used by Data importers in Terraform and CDK
  subnet_tags = ["Tier", "aws-cdk:subnet-type", "aws-cdk:subnet-name"]
}
