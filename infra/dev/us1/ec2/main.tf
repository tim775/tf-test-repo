provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

resource "aws_db_instance" "aws_db_instance" {
  identifier                      = "provider-rds"
  allocated_storage               = 1000
  engine                          = "postgres"
  engine_version                  = "15"
  instance_class                  = "db.m5.large"
  storage_type                    = "gp3"
  multi_az                        = true
  username                        = "var.db_username"
  password                        = "aws_secretsmanager_secret_version.aws_secretsmanager_secret_version.secret_string"
  // vpc_security_group_ids          = [data.aws_security_group.deere_postgresql.id]
  // db_subnet_group_name            = aws_db_subnet_group.db.id
  storage_encrypted               = true
  copy_tags_to_snapshot           = true
  apply_immediately               = true
  // tags                            = local.default_tags
  ca_cert_identifier              = "rds-ca-rsa2048-g1"
  skip_final_snapshot             = true
  enabled_cloudwatch_logs_exports = ["postgresql"]
}


resource "aws_instance" "web_app" {
  ami           = "ami-674cbc1e"
  instance_type = "m4.xlarge"

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

resource "aws_instance" "web_app_new2" {
  ami           = "ami-674cbc1e"
  instance_type = "m4.xlarge"
}
