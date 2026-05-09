variable "aws_region"   { default = "eu-west-1" }
variable "db_password"  { sensitive = true }
# These reference outputs from shared-infra repo (test-case-8a)
variable "shared_vpc_name"    { default = "shared-vpc" }
variable "shared_app_sg_name" { default = "shared-app-sg" }
variable "shared_db_sg_name"  { default = "shared-db-sg" }
variable "shared_role_name"   { default = "shared-app-role" }
