resource "aws_s3_bucket" "static" {
  bucket = var.bucketName
  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}


resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.static.id
  policy = templatefile("templates/s3-policy.json", { bucket = var.bucketName })
}


resource "aws_s3_object" "object-index" {
  bucket       = aws_s3_bucket.static.id
  key          = "index.html"
  source       = "index.html"
  acl          = "public-read"
  content_type = "text/html"
}


data "aws_route53_zone" "selected" {
  name = var.domainName
}

resource "aws_route53_record" "domainName" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.domainName
  type    = "A"
  alias {
    name                   = aws_s3_bucket.static.website_endpoint
    zone_id                = aws_s3_bucket.static.hosted_zone_id
    evaluate_target_health = true
    ttl                    = "300"
  }
}