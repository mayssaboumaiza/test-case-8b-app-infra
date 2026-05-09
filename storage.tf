resource "aws_s3_bucket" "app" {
  bucket = "app-data-prod"
  tags   = { Role = "app-storage" }
}
resource "aws_sqs_queue" "events" {
  name = "app-events"
}
