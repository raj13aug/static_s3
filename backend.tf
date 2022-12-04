terraform {
  backend "s3" {
    bucket = "cloudroot-007"
    key    = "s3/static"
    region = "us-east-1"
  }
}