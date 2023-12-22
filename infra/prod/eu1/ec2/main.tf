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
    volume_type = "gp2"
    tags = {
      "ef" = "rbd"
    }
  }
}

