locals {
  tags = merge({
    Name    = "${var.company}-infrastructure"
    Company = var.company
  }, var.tags)

  app_list = keys(var.apps)

  vpc_cidr        = "172.16.0.0/16"
  public_subnets  = flatten([for i in range(0, length(local.app_list)) : [for j in range(0, 3) : "172.16.${i}.${j * 32}/27"]])
  private_subnets = flatten([for i in range(0, length(local.app_list)) : [for j in range(0, 3) : "172.16.${i}.${128 + (j * 32)}/27"]])
}
