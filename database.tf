resource "aws_db_subnet_group" "app" {
  name       = "app-db-subnet"
  subnet_ids = [data.aws_subnet.app.id, data.aws_subnet.db.id]
}
resource "aws_db_instance" "app" {
  identifier             = "app-postgres"
  engine                 = "postgres"
  engine_version         = "15.4"
  instance_class         = "db.t3.medium"
  allocated_storage      = 50
  username               = "admin"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.app.name
  vpc_security_group_ids = [data.aws_security_group.db_sg.id]
  skip_final_snapshot    = true
  depends_on = [aws_db_subnet_group.app]
}
