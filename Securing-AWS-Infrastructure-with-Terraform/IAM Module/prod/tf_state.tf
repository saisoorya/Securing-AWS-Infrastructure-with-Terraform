resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "cy7900-terraform-lock-prod"

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
  read_capacity  = 1
  write_capacity = 1
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Team        = "C7900"
    Name        = "Terraform state lock table"
    Environment = "dev"
  }
}
