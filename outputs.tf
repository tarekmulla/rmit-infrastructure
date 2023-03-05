output "dynamodb_name" {
  description = "The Statelock DynamoDB table name to be used with projects"
  value       = module.remote_state.dynamodb_name
}

output "vpc_id" {
  description = "The netwrok VPC ID"
  value       = module.network.vpc_id
}

output "name_servers" {
  description = "The name servers for the main hosted route53 zone"
  value       = module.dns.name_servers
}
