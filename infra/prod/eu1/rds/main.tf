provider "aws" {
  region                      = "eu-west-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

resource "aws_db_instance" "mysql" {
  engine         = "mysql"
  instance_class = "db.t3.2xlarge"
}
