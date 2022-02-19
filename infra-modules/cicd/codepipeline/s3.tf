resource "aws_s3_bucket" "main" {
  force_destroy = true
  acl           = "private"
  bucket        = "${var.bucket_name}-${var.environment}"
  region        = var.region
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
}

