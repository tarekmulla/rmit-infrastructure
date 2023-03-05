output "dynamodb_name" {
  description = "The Statelock DynamoDB table name to be used with projects"
  value       = module.remote_state.dynamodb_name
}

output "vpc_id" {
  description = "The netwrok VPC ID"
  value       = module.network.vpc_id
}

output "vpc_cidr" {
  description = "The netwrok VPC CIDR"
  value       = local.vpc_cidr
}

output "public_subnets" {
  description = "All subnets created in the VPC"
  value       = [for i in range(0, length(var.apps)): {
    "application" : var.apps[i],
    "public_subnets": slice(local.public_subnets, i*3, i*3+3),
    "private_subnets": slice(local.private_subnets, i*3, i*3+3)
  }]
}
