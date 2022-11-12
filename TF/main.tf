module "main" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = "${local.resource_prefix}-main_vpc"
  cidr = local.main_vpc_cidr

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true

  create_database_subnet_group           = true
  create_database_subnet_route_table     = false
  create_database_internet_gateway_route = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_vpn_gateway = false
  

  tags = local.tags
}