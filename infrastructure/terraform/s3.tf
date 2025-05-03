resource "aws_s3_bucket" "frontend_assets" {
  bucket        = "ecommerce-frontend-assets-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.frontend_assets.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
