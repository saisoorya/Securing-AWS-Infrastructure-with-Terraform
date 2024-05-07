# Create S3 Bucket
resource "aws_s3_bucket" "capstone" {
  bucket = "cy7900-s3-prod-usw2"
}

# Configure S3 Bucket Public Access Block
resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket                     = aws_s3_bucket.capstone.id
  block_public_acls          = true
  block_public_policy        = true
  ignore_public_acls         = true
  restrict_public_buckets    = true
}

# Existing ECS and EC2 IAM policies and roles omitted for brevity...

# Create S3 Bucket Policy that includes EC2 and ECS roles
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.capstone.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "ReadWriteForSpecificUsersAndRoles",
        Effect    = "Allow",
        Principal = {
          AWS = [
            "arn:aws:iam::269471155370:role/EC2-Role",
            "arn:aws:iam::269471155370:role/cy7900-ecsEc2InstanceRole",
            "arn:aws:iam::269471155370:role/cy7900-ecsTaskRole"
          ]
        },
        Action    = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:GetObjectVersion",
          "s3:PutObjectAcl",
          "s3:GetObjectAcl",
          "s3:DeleteObjectVersion"
        ],
        Resource  = [
          "arn:aws:s3:::cy7900-s3-prod-usw2",
          "arn:aws:s3:::cy7900-s3-prod-usw2/*"
        ]
      }
    ]
  })
}
