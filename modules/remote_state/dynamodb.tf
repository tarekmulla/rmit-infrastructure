resource "aws_dynamodb_table" "dynamodb_terraform_lock" {
  name         = "terraform-statelock-${var.company}"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.tags
}
