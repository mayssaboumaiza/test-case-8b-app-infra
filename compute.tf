resource "aws_instance" "api" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t3.medium"
  subnet_id              = data.aws_subnet.app.id
  vpc_security_group_ids = [data.aws_security_group.app_sg.id]
  iam_instance_profile   = data.aws_iam_instance_profile.app.name
  tags = { Role = "api-server", DependsOn = "shared-infra" }
}
resource "aws_lambda_function" "processor" {
  function_name = "app-processor"
  runtime       = "python3.11"
  handler       = "processor.handler"
  role          = data.aws_iam_instance_profile.app.role_arn
  filename      = "processor.zip"
  vpc_config {
    subnet_ids         = [data.aws_subnet.app.id]
    security_group_ids = [data.aws_security_group.app_sg.id]
  }
  environment {
    variables = {
      DB_HOST   = aws_db_instance.app.address
      S3_BUCKET = aws_s3_bucket.app.bucket
    }
  }
  depends_on = [aws_db_instance.app]
}
