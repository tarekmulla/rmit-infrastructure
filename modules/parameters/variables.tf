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

variable "ecr_image" {
  type        = string
  description = "The url for the docker image"
}

variable "vpc_id" {
  type        = string
  description = "The shared netwrok VPC Id"
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "List of IDs of public subnets"
}

variable "vpc_private_subnets" {
  type        = list(string)
  description = "List of IDs of private subnets"
}
