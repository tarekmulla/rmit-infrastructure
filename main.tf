provider "aws" {
  region = var.region
}

# The network components (VPC, subnets, Internet gateway, etc..)
module "network" {
  source              = "./modules/network"
  company             = var.company
  region              = var.region
  availability_zones  = ["${var.region}a", "${var.region}b", "${var.region}c"]
  vpc_cidr            = local.vpc_cidr
  private_subnet_cidr = local.private_subnets
  public_subnet_cidr  = local.public_subnets
  tags                = local.tags
}

# DynamodB STatelock table
module "remote_state" {
  source  = "./modules/remote_state"
  company = var.company
  tags    = local.tags
}

# ECR repositories for projects
module "ecs_repo" {
  for_each = toset(var.apps)
  source   = "./modules/ecs_repo"
  app      = each.key
  region   = var.region
  tags     = local.tags
}
