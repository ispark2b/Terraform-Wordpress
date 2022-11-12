locals {

  #AWS Account Config
  account_id = data.aws_caller_identity.current.account_id
  resource_prefix = var.resource_prefix

  #EC2 Config
  instance_type = "t2.micro"
  wordpress_version = var.wordpress_version

  #RDS Config
  db_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  db_port = var.db_port
  db_instance_size = var.db_instance_size
  
  #Access Logs
  s3_lb_logs_bucket_name = "${local.resource_prefix}-${local.account_id}-ALB_LOGS"

  #VPC Config
  main_vpc_cidr = "10.0.0.0/16"
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  azs = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

  #Tags
  tags = {
    deployment = "Terraform",
    stage = var.stage
    project = var.project
    terraform_version = var.tf_version
    timestamp = formatdate("YYYYMMDDhhmmss", timestamp())
  }
}