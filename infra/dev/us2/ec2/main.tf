provider "aws" {
  region                      = "us-east-2"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

resource "aws_instance" "web_app" {
  ami           = "ami-674cbc1e"
  instance_type = "t3.large"
}

resource "aws_lambda_alias" "test_lambda_alias" {
  name             = "my_moother_alias"
  description      = "a sample description"
  function_name    = "aws_lambda_function.lambda_function_test.arn"
  function_version = "1"
}
