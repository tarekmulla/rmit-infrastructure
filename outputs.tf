output "dynamodb_name" {
  description = "The Statelock DynamoDB table name to be used with projects"
  value       = module.remote_state.dynamodb_name
}

output "vpc_id" {
  description = "The netwrok VPC ID"
  value       = module.network.vpc_id
}
