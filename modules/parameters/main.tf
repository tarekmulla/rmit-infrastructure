resource "aws_ssm_parameter" "ecr_image" {
  name  = "/${var.app}/ecr_image"
  type  = "String"
  value = var.ecr_image
  tags  = var.tags
}

resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.app}/vpc_id"
  type  = "String"
  value = var.vpc_id
  tags  = var.tags
}

resource "aws_ssm_parameter" "vpc_public_subnets" {
  name  = "/${var.app}/vpc_public_subnets"
  type  = "String"
  value = jsonencode(var.vpc_public_subnets)
  tags  = var.tags
}

resource "aws_ssm_parameter" "vpc_private_subnets" {
  name  = "/${var.app}/vpc_private_subnets"
  type  = "String"
  value = jsonencode(var.vpc_private_subnets)
  tags  = var.tags
}
