variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "bucket_names" {
  description = "The name of the S3 buckets"
  type        = list(string)
  default     = ["my-unique-bucket-12345-519", "my-unique-bucket-12345-520"]
}

variable "bucket_tags" {
  description = "Tags to apply to S3 buckets"
  type        = map(string)
  default     = {
    Environment = "Dev"
    Project     = "TerraformLearning"
  }
}
