resource "aws_s3_bucket" "example" {
  bucket = var.bucketName
}


resource "aws_s3_bucket_policy" "example-policy" {
  bucket = aws_s3_bucket.example.id
  policy = templatefile("templates/s3-policy.json", { bucket = var.bucketName })
}


resource "aws_s3_object" "example-index" {
  bucket       = aws_s3_bucket.example.id
  key          = "index.html"
  source       = "index.html"
  acl          = "public-read"
  content_type = "text/html"
}