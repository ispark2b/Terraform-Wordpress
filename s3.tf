resource "aws_s3_bucket" "lb-logs" {
  bucket = local.s3_lb_logs_bucket_name
  #When will be with logs, terraform can still destroy it
  force_destroy = true

  tags = local.tags
}

resource "aws_s3_bucket_acl" "lb-logs" {
  bucket = aws_s3_bucket.lb-logs.id
  acl    = "private"
}