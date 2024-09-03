provider "aws" {
  region                      = "eu-west-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

resource "aws_instance" "web_app" {
  ami           = "ami-674cbc1e"
  instance_type = "t3.xlarge"

  tags = {
    "bat"  = "ball"
    "fizz" = "buzz"
    "ef" = "rbd"
  }

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
    tags = {
      "ef" = "rbd"
    }
  }
}

resource "aws_instance" "web_app333" {
  ami           = "ami-674cbc1e"
  instance_type = "t2.medium"

  tags = {
    "bat"  = "ball"
    "fizz" = "buzz"
    "ef" = "rbd"
  }

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
    tags = {
      "ef" = "rbd"
    }
  }
}

resource "aws_instance" "web_app7" {
  ami           = "ami-674cbc1e"
  instance_type = "t3.xlarge"

  tags = {
    "bat"  = "ballaaa"
    "fizz" = "buzz"
    "ef" = "rbd"
  }

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
    tags = {
      "ef" = "rbd"
    }
  }
}


resource "aws_subnet" "one_gateway" {
  vpc_id     = "subnet-12345678"
  cidr_block = "10.0.1.0/24"
}

resource "aws_nat_gateway" "passing_1" {
  allocation_id = "eip-12345678"
  subnet_id     = aws_subnet.one_gateway.id
}

resource "aws_nat_gateway" "breaks_passing_1" {
  allocation_id = "eip-12345678"
  subnet_id     = aws_subnet.one_gateway.id
}

resource "aws_subnet" "two_gateways" {
  vpc_id     = "subnet-22345678"
  cidr_block = "10.0.1.0/24"
}

resource "aws_nat_gateway" "failing_1" {
  allocation_id = "eip-22345678"
  subnet_id     = aws_subnet.two_gateways.id
}

resource "aws_nat_gateway" "failing_2" {
  allocation_id = "eip-22345678"
  subnet_id     = aws_subnet.two_gateways.id
}

resource "aws_subnet" "two_gateways2" {
  vpc_id     = "subnet-22345678"
  cidr_block = "10.0.1.0/24"
}

resource "aws_nat_gateway" "failing_3" {
  allocation_id = "eip-22345678"
  subnet_id     = aws_subnet.two_gateways2.id
}

resource "aws_vpc" "one_endpoint" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
}

resource "aws_vpc_endpoint" "passing_1_one_endpoint" {
  service_name      = "com.amazonaws.region.ec2"
  vpc_id            = aws_vpc.one_endpoint.id
  vpc_endpoint_type = "Interface"
}

resource "aws_vpc" "different_service_endpoints" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
}

resource "aws_vpc_endpoint" "passing_2_different_service_endpoints" {
  service_name      = "com.amazonaws.region.ec2"
  vpc_id            = aws_vpc.different_service_endpoints.id
  vpc_endpoint_type = "Interface"
}

resource "aws_vpc_endpoint" "passing_3_different_service_endpoints" {
  service_name      = "com.amazonaws.region.ec2"
  vpc_id            = aws_vpc.different_service_endpoints.id
  vpc_endpoint_type = "Interface"
}


resource "aws_vpc" "two_interface_endpoints" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
}

resource "aws_vpc_endpoint" "failing_1_two_interface_endpoints" {
  service_name      = "com.amazonaws.region.fixes_two_interface_endpoints"
  vpc_id            = aws_vpc.two_interface_endpoints.id
  vpc_endpoint_type = "Interface"
}

resource "aws_vpc_endpoint" "failing_2_two_interface_endpoints" {
  service_name      = "com.amazonaws.region.ec2"
  vpc_id            = aws_vpc.two_interface_endpoints.id
  vpc_endpoint_type = "Interface"
}

resource "aws_vpc" "two_endpoints_of_different_type" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
}

resource "aws_vpc_endpoint" "failing_3_two_endpoints_of_different_type" {
  service_name      = "com.amazonaws.region.ec2"
  vpc_id            = aws_vpc.two_endpoints_of_different_type.id
  vpc_endpoint_type = "Interface"
}

resource "aws_vpc_endpoint" "failing_4_two_endpoints_of_different_type" {
  service_name      = "com.amazonaws.region.ec3"
  vpc_id            = aws_vpc.two_endpoints_of_different_type.id
  vpc_endpoint_type = "GatewayLoadBalancer"
}

resource "aws_vpc_endpoint" "failing_5_make_it_worse_two_endpoints_of_different_type" {
  service_name      = "com.amazonaws.region.ec4"
  vpc_id            = aws_vpc.two_endpoints_of_different_type.id
  vpc_endpoint_type = "GatewayLoadBalancer"
}

resource "aws_vpc_endpoint" "failing_6_make_it_worse_two_endpoints_of_different_type" {
  service_name      = "com.amazonaws.region.ec5"
  vpc_id            = aws_vpc.two_endpoints_of_different_type.id
  vpc_endpoint_type = "GatewayLoadBalancer"
}

resource "aws_vpc_endpoint" "failing_7_make_it_worse_two_endpoints_of_different_type" {
  service_name      = "com.amazonaws.region.ec6"
  vpc_id            = aws_vpc.two_endpoints_of_different_type.id
  vpc_endpoint_type = "GatewayLoadBalancer"
}

resource "aws_vpc_endpoint" "failing_8_two_endpoints_of_different_type" {
  service_name      = "com.amazonaws.region.ec2"
  vpc_id            = aws_vpc.two_endpoints_of_different_type.id
  vpc_endpoint_type = "Interface"
}

module "endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = "vpc-12345678"
  security_group_ids = ["sg-12345678"]

  endpoints = {
    s3 = {
      # interface endpoint
      service             = "s3"
      tags                = { Name = "s3-vpc-endpoint" }
    },
    dynamodb = {
      # gateway endpoint
      service         = "dynamodb"
      route_table_ids = ["rt-12322456", "rt-43433343", "rt-11223344"]
      tags            = { Name = "dynamodb-vpc-endpoint" }
    },
    sns = {
      service    = "sns"
      subnet_ids = ["subnet-12345678", "subnet-87654321"]
      tags       = { Name = "sns-vpc-endpoint" }
    },
    sqs = {
      service             = "sqs"
      private_dns_enabled = true
      security_group_ids  = ["sg-987654321"]
      subnet_ids          = ["subnet-12345678", "subnet-87654321"]
      tags                = { Name = "sqs-vpc-endpoint" }
    },
  }

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

