# RMIT Infrastructure #

This repo contains all shared AWS resources between RMIT projects.

## How does it work ##

The project builds two types of resources:
1. All shared resources between RMIT projects, those resources include:
   * VPC Network
   * NAT Gateway
   * DynamoDB statelock table

2. The project takes a list of project names, and create all required base resources for each application, the base resources include:
   * VPC Subnets
   * ECR repository

## Remote state ##

The state of this project will be stored in manually-created s3 bucket called terraform-statebucket-rmit.
The bucket exist in the RMIT aws account.

## How do I get set up? ##

* Install [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* Install and configure [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions)
* Create `terraform.tfvars` file, that copied from `terraform.tfvars.example` and update values.
* Init, plan and apply terraform. See: [Provisioning Infrastructure](https://developer.hashicorp.com/terraform/cli/run)
