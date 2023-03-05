output "dynamodb_name" {
  description = "The DynamoDB name where terraform will store lockstate file"
  value       = aws_dynamodb_table.dynamodb_terraform_lock.name
}
