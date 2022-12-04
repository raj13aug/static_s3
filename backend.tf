terraform {
  backend "s3" {
    bucket = "cloudroot-backend"
    key    = "static"
    region = "us-east-1"
  }
}