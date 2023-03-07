variable "app" {
  type        = string
  description = "The application name"
}

variable "company" {
  type        = string
  description = "The company name"
}

variable "tags" {
  description = "AWS Tags to add to all resources created (where possible)"
  type        = map(string)
}
