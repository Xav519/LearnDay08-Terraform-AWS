
// Task 1
resource "aws_s3_bucket" "example" {
  // With Count, resources are adresssed using index
  // Ex: aws_s3_bucket.example[0]
  count = length(var.bucket_names)
  bucket = var.bucket_names[count.index]
  tags = var.bucket_tags
}
// Task 2
resource "aws_s3_bucket" "exampleTask02" {
  // With For_Each, resources are adresssed using the value directly
  // Ex: aws_s3_bucket.exampleTask02["my-unique-bucket-12345-519"]
  for_each = var.bucket_names
  bucket = each.value
  tags = var.bucket_tags
}