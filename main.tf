provider "aws" {
  region = var.region
}

provider "aws" {
  region = "us-east-1"
  alias  = "virginia"
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

# Project bucket
module "project_bucket" {
  for_each = toset(local.app_list)
  source   = "./modules/bucket"
  app      = each.key
  company  = var.company
  tags     = local.tags
}

# ------------------------------
# Create route53 region, point to it in the parent domain, and create required certificates
module "dns" {
  for_each      = toset(local.app_list)
  source        = "./modules/dns"
  parent_domain = var.main_domain
  domain        = "${each.key}.${var.main_domain}"
}
module "certificate" {
  for_each    = toset(local.app_list)
  source      = "./modules/certificate"
  domain_name = var.apps[each.key]["website-domain"]
  zone_id     = module.dns[each.key].zone_id
  SAN_domains = [
    "*.${var.apps[each.key]["website-domain"]}",
    "cognito.${var.apps[each.key]["website-domain"]}",
    "api.${var.apps[each.key]["website-domain"]}"
  ]
  tags       = merge({ Application = each.key }, var.tags)
  depends_on = [module.dns]
}
module "cognito_certificate" {
  for_each    = toset(local.app_list)
  source      = "./modules/certificate"
  domain_name = var.apps[each.key]["website-domain"]
  zone_id     = module.dns[each.key].zone_id
  SAN_domains = [
    "*.${var.apps[each.key]["website-domain"]}",
    "cognito.${var.apps[each.key]["website-domain"]}",
    "api.${var.apps[each.key]["website-domain"]}"
  ]
  tags = merge({ Application = each.key }, var.tags)
  providers = {
    aws = aws.virginia # cognito certificate should be created in us-east-1
  }
  depends_on = [module.dns]
}


# ------------------------------
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
  zone_id             = module.dns[each.key].zone_id
  tags                = local.tags
}
