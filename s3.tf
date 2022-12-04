resource "aws_s3_bucket" "static" {
  bucket = var.bucketName
}


resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.static.id
  policy = templatefile("templates/s3-policy.json", { bucket = var.bucketName })
}


resource "aws_s3_object" "example-index" {
  bucket       = aws_s3_bucket.static.id
  key          = "index.html"
  source       = "index.html"
  acl          = "public-read"
  content_type = "text/html"
}