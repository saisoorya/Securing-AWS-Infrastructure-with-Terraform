resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "cy7900-terraform-lock-dev"

  tags = {
    Name        = "Terraform state file bucket"
    Team        = "CY7900"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "tf_state_bucket" {
  bucket = aws_s3_bucket.tf_state_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_dynamodb_table" "terraform_lock_table" {
  name           = "terraform-state-lock-dev"
  billing_mode   = "PROVISIONED"
  hash_key       = "LockID"

  tags = {
    Team        = "C7900"
    Name        = "Terraform state lock table"
    Environment = "dev"
  }
}
