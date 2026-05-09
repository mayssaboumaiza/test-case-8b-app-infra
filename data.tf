# Cross-repo data sources: read resources created by test-case-8a-shared-infra
data "aws_vpc" "shared" {
  filter { name = "tag:Name"; values = [var.shared_vpc_name] }
}
data "aws_subnet" "app" {
  filter { name = "tag:Name"; values = ["shared-app-subnet"] }
}
data "aws_subnet" "db" {
  filter { name = "tag:Name"; values = ["shared-db-subnet"] }
}
data "aws_security_group" "app_sg" {
  name   = var.shared_app_sg_name
  vpc_id = data.aws_vpc.shared.id
}
data "aws_security_group" "db_sg" {
  name   = var.shared_db_sg_name
  vpc_id = data.aws_vpc.shared.id
}
data "aws_iam_instance_profile" "app" {
  name = "shared-app-profile"
}
