variable "tags" {
  description = "AWS Tags to add to all resources created (where possible)"
  type        = map(string)
}

variable "main_domain" {
  type        = string
  description = "The parent domain for all applications"
}
