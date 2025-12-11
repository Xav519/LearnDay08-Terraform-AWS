# Terraform Count & For_Each - Day 8 Summary

## Overview

This repository contains Day 8 exercises focusing on **Terraform `count`, `for_each`, and for expressions**. The goal was to learn how to:

* Create multiple AWS S3 buckets using a single resource block.
* Iterate over lists and sets of values using `count` and `for_each`.
* Use outputs with **for expressions** to summarize deployed resources.

Each task demonstrates a different approach to resource iteration and output generation in Terraform.

*Refer to Day08_Tasks.md for detailed task instructions.*

---

## Tasks & What I Implemented

### Task 1 - Using `count` to Create Multiple Buckets

**Variable**

* `bucket_names` (list(string)) - `["my-first-bucket", "my-second-bucket"]`

**Objective**
Create multiple S3 buckets using a single resource block with `count`.

**Action**

* Defined `count = length(var.bucket_names)` on the S3 bucket resource.
* Set `bucket = var.bucket_names[count.index]` to assign bucket names dynamically.
* Ran `terraform plan` and `terraform apply` to verify creation.

**Example**

```hcl
resource "aws_s3_bucket" "buckets" {
  count  = length(var.bucket_names)
  bucket = var.bucket_names[count.index]
}
```

---

### Task 2 - Using `for_each` to Create Multiple Buckets

**Variable**

* `bucket_names` (set(string)) - `["my-first-bucket", "my-second-bucket"]`

**Objective**
Create multiple S3 buckets using a single resource block with `for_each`.

**Action**

* Defined `for_each = var.bucket_names` on the S3 bucket resource.
* Set `bucket = each.value` to assign bucket names dynamically.
* Compared resource addressing:

  * `count` → `aws_s3_bucket.buckets[0]`
  * `for_each` → `aws_s3_bucket.buckets["my-first-bucket"]`

**Example**

```hcl
resource "aws_s3_bucket" "buckets" {
  for_each = var.bucket_names
  bucket   = each.value
}
```

---

### Task 3 - Output with For Expressions

**Objective**
Display all bucket information using Terraform outputs and `for` expressions.

**Action**

* Created outputs to list bucket names and IDs dynamically:

```hcl
output "bucket_names" {
  description = "List of all S3 bucket names"
  value       = [for b in aws_s3_bucket.buckets : b.bucket]
}

output "bucket_ids" {
  description = "List of all S3 bucket IDs"
  value       = [for b in aws_s3_bucket.buckets : b.id]
}
```

* Ran `terraform output` to verify results.

---

## How to Run / Quick Commands

```bash
terraform init
terraform plan
terraform apply -auto-approve
terraform output
```

---

## Notes

* Use `count` when iterating over an **ordered list**.
* Use `for_each` when iterating over a **set or map**, especially when names are meaningful.
* Outputs with **for expressions** help summarize resources in lists or maps.
* `for_each` resources can be addressed by key (`aws_s3_bucket.buckets["bucket-name"]`), which is easier to maintain than numeric indexing with `count`.

---

## Summary

Day 8 exercises provided hands-on practice using Terraform to:

* Dynamically create multiple resources with `count` and `for_each`.
* Understand differences between numeric indexing and key-based resource addressing.
* Aggregate resource data using outputs and `for` expressions.

---

## Reference

* [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* AWS Terraform Full Course - #30daysofawsterraform https://www.youtube.com/watch?v=xUtGqC-NXJE&list=PLl4APkPHzsUXcfBSJDExYR-a4fQiZGmMp
* Terraform `count` & `for_each` Tutorial, HashiCorp Docs.
* Terraform Outputs & For Expressions Documentation.
