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
  for_each = toset(local.app_list)
  source   = "./modules/ecs_repo"
  app      = each.key
  tags     = local.tags
}

module "certificate" {
  for_each    = toset(local.app_list)
  source      = "./modules/certificate"
  domain_name = var.apps[each.key]["website-domain"]
  SAN_domains = ["*.${var.apps[each.key]["website-domain"]}", var.apps[each.key]["api-endpoint"]]
  tags        = merge({ Application = each.key }, var.tags)
}

# SSM parameters for each application
module "parameters" {
  for_each            = toset(local.app_list)
  source              = "./modules/parameters"
  app                 = each.key
  ecr_image           = module.ecs_repo[each.key].image_url
  vpc_id              = module.network.vpc_id
  vpc_public_subnets  = slice(module.network.vpc_public_subnets, index(local.app_list, each.key) * 3, index(local.app_list, each.key) * 3 + 3)
  vpc_private_subnets = slice(module.network.vpc_private_subnets, index(local.app_list, each.key) * 3, index(local.app_list, each.key) * 3 + 3)
  website_domain      = var.apps[each.key]["website-domain"]
  api_endpoint        = var.apps[each.key]["api-endpoint"]
  certificate_arn     = module.certificate[each.key].arn
  tags                = local.tags
}
