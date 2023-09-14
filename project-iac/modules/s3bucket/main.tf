resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-unique-bucket-015"
  acl = "private"
}