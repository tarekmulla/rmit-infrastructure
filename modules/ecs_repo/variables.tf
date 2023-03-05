variable "region" {
  type        = string
  description = "The AWS region name where the resources will be provisioned"
}

variable "app" {
  type        = string
  description = "The application name"
}

# A map of the extra tags to apply to aws resources.
# there is already list of tags will be added by default, please check locals "tags"
variable "tags" {
  description = "AWS Tags to add to all resources created (where possible)"
  type        = map(string)
  default     = {}
}
