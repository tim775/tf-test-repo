provider "aws" {
  region                      = "us-east-2"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

resource "aws_instance" "web_apppp" {
  ami           = "ami-674cbc1e"
  instance_type = "t3.2xlarge"
  root_block_device {
    volume_size = 10
  }
}

resource "aws_instance" "web_apppp2222" {
  ami           = "ami-674cbc1e"
  instance_type = "t4.62xlarge"
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
}
