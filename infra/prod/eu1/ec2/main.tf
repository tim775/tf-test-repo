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

resource "aws_instance" "web_app7" {
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
  service_name      = "com.amazonaws.region.ec2"
  vpc_id            = aws_vpc.two_endpoints_of_different_type.id
  vpc_endpoint_type = "GatewayLoadBalancer"
}

