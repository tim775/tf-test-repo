provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

resource "aws_instance" "web_app" {
  ami           = "ami-674cbc1e"
  instance_type = "g3.4xlarge"

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
