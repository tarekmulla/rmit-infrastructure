output "image_url" {
  description = "The URL for the ER image"
  value       = aws_ecr_repository.repo.repository_url
}
