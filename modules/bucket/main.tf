# S3 bucket to store the projects artifacts and templates
resource "aws_s3_bucket" "project" {
  bucket        = "${var.company}-${var.app}"
  force_destroy = true
  tags          = var.tags
}

# enable SSE-S3 encryption in the bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "project_encryption" {
  bucket = aws_s3_bucket.project.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Enable objects versioning
resource "aws_s3_bucket_versioning" "project_versioning" {
  bucket = aws_s3_bucket.project.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Block S3 public access
resource "aws_s3_bucket_acl" "project_acl" {
  bucket = aws_s3_bucket.project.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "project_block" {
  bucket = aws_s3_bucket.project.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
