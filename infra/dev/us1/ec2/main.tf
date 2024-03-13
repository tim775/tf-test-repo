provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

resource "aws_instance" "web_app" {
  ami           = "ami-674cbc1e"
  instance_type = "t3.4xlarge"

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

resource "aws_lambda_function" "hello_world" {
  function_name = "hello_world"
  role          = "arn:aws:lambda:us-east-1:aws:resource-id"
  handler       = "exports.test"
  runtime       = "nodejs12.x"
  filename      = "function.zip"
  memory_size   = 1024 # <<<<< Try changing this to 512 to compare costs
}
