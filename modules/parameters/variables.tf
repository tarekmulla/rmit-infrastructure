variable "app" {
  type        = string
  description = "The application name"
}

variable "tags" {
  description = "AWS Tags to add to all resources created (where possible)"
  type        = map(string)
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

variable "website_domain" {
  type        = string
  description = "The domain name for the web application"
}

variable "api_endpoint" {
  type        = string
  description = "The api endpoint"
}

variable "zone_id" {
  type        = string
  description = "The main hosted route53 zone id"
}
