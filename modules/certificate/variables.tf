# A map of the extra tags to apply to aws resources.
# there is already list of tags will be added by default, please check locals "tags"
variable "tags" {
  description = "AWS Tags to add to all resources created (where possible)"
  type        = map(string)
}

variable "domain_name" {
  type        = string
  description = "The application domain name"
}

variable "SAN_domains" {
  type        = list(string)
  description = "The subject alternative domains to include in the certificate (API domain, etc..)"
}
