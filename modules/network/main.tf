module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.company}-vpc"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnet_cidr
  public_subnets  = var.public_subnet_cidr
  create_igw      = true

  create_database_subnet_group           = false
  create_database_subnet_route_table     = false
  create_database_internet_gateway_route = false

  # Single NAT Gateway for all subnets and avilability zones
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_vpn_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true
}
