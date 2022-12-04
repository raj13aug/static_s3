resource "aws_s3_bucket" "example" {
  bucket = var.bucketName
  acl    = "public-read"
  website {
    index_document = "index.html"
    #error_document = "404.html"
  }
}

resource "aws_s3_bucket_website_configuration" "example-config" {
  bucket = aws_s3_bucket.example.bucket
}

resource "aws_s3_bucket_policy" "example-policy" {
  bucket = aws_s3_bucket.example.id
  policy = templatefile("templates/s3-policy.json", { bucket = var.bucketName })
}


resource "aws_s3_object" "example-index" {
  bucket = aws_s3_bucket.example.id
  key    = "index.html"
  source = "index.html"
  acl    = "public-read"
}