terraform {
    backend "s3" {
        bucket         = "cy7900-terraform-lock-prod"
        dynamodb_table = "terraform-state-lock-dev"
        key            = "meta/state/terraform-cy7900-s3/terraform.tfstate"
        region         = "us-west-2"
    }
}