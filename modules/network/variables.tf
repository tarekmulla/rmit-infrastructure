variable "region" {
  type        = string
  description = "The aws region where the resources will be provisioned"
}

variable "company" {
  type        = string
  description = "The company name"
}

variable "tags" {
  description = "AWS Tags to add to all resources created (where possible)"
  type        = map(string)
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "private_subnet_cidr" {
  type        = list(string)
  description = "List of CIDR blocks for private subnets"
}

variable "public_subnet_cidr" {
  type        = list(string)
  description = "List of CIDR blocks for public subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availablility zones"
}
