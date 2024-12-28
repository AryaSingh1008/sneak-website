resource "aws_s3_bucket" "aryabucket" {
  bucket = "aryabucketoinfy"

}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.aryabucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.aryabucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.aryabucket.id
  acl    = "public-read"
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.aryabucket.id
  key          = "index.html"
  source       = "index.html"
  acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.aryabucket.id
  key          = "error.html"
  source       = "error.html"
  acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "sneaker1" {
  bucket = aws_s3_bucket.aryabucket.id
  key    = "sneaker1.jpg"
  source = "sneaker1.jpg"
  acl    = "public-read"
}

resource "aws_s3_object" "sneaker2" {
  bucket = aws_s3_bucket.aryabucket.id
  key    = "sneaker2.jpg"
  source = "sneaker2.jpg"
  acl    = "public-read"
}

resource "aws_s3_object" "sneaker3" {
  bucket = aws_s3_bucket.aryabucket.id
  key    = "sneaker3.jpg"
  source = "sneaker3.jpg"
  acl    = "public-read"
}
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.aryabucket.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  depends_on = [aws_s3_bucket_acl.example]
}
