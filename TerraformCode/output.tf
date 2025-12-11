// Task 03
output "s3_bucket_names_task03" {
  description = "Names of S3 buckets"
  value = [for b in aws_s3_bucket.example : b.bucket]
}

// Task 03
output "s3_bucket_ids_task03" {
  description = "IDs of S3 buckets"
  value = [for b in aws_s3_bucket.example : b.id]
}