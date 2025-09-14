provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

module "notify_slack" {
  source  = "terraform-aws-modules/notify-slack/aws"
  version = "6.5.0"

  sns_topic_name   = "topic_name"
  create_sns_topic = false

  slack_webhook_url = "https://wwww.webjhook.url"
  slack_channel     = "production-dev"
  slack_username    = "incoming-webhook"
}

resource "aws_db_instance" "aws_db_instance" {
  identifier                      = "provider-rds"
  allocated_storage               = 1000
  engine                          = "postgres"
  engine_version                  = "15"
  instance_class                  = "db.m5.2xlarge"
  storage_type                    = "gp2"
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
  instance_type = "m4.small"

  tags = {
    "bat"  = "ball"
    "fizz" = "buzz"
    "ef" = "rbd"
    "n" = "fa22222zzzz1111z2"
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

resource "aws_instance" "web_app_new3" {
  ami           = "ami-674cbc1e"
  instance_type = "m4.xlarge"
}
