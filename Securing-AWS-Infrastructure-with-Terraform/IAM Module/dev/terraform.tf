terraform {
    backend "s3" {
        bucket         = "cy7900-terraform-lock-dev"
        dynamodb_table = "terraform-state-lock-dev"
        key            = "meta/state/terraform-cy7900-iam/terraform.tfstate"
        region         = "us-west-2"
    }
}
