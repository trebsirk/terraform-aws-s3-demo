variable "aws_region" {
    type = string
}
variable "acl" {
    type = string
}
variable "bucket_name" {
    type = string
}
variable "env" {
    type = string
}
# Configure the AWS provider
provider "aws" {
  region = var.aws_region  # Use variable from terraform.tfvars
}

# Define an S3 bucket resource
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name  # Use variable from terraform.tfvars
  acl    = var.acl         # Use variable from terraform.tfvars (optional)
  
  tags = {
    "env" = var.env
  }
}

# Optional: Versioning for the S3 bucket
resource "aws_s3_bucket_public_access_block" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
