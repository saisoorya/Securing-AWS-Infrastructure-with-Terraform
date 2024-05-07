module "cy7900_ecs_iam" {
    source = "../common_modules/iam"
    app_name = local.app_name
    common_tags = local.common_tags
}

data "aws_iam_policy_document" "ecs_cross_account_s3_policy" {
  statement {
    effect = "Allow"

    actions = [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:GetBucketLocation"
    ]

    resources = [
      "arn:aws:s3:::cy7900-s3-prod-usw2",
      "arn:aws:s3:::cy7900-s3-prod-usw2/*"
    ]
  }
}

resource "aws_iam_policy" "ecs_cross_account_s3_policy" {
  name     = "${local.app_name}_ecs_cross_account_s3_policy"
  policy   = data.aws_iam_policy_document.ecs_cross_account_s3_policy.json
}


resource "aws_iam_role_policy_attachment" "cross_account_s3_policyattach" {
  role       = module.cy7900_ecs_iam.ecs_task_role_name
  policy_arn = aws_iam_policy.ecs_cross_account_s3_policy.arn
}

resource "aws_iam_role_policy_attachment" "cross_account_s3_instance_role_policyattach" {
  role       = module.cy7900_ecs_iam.ecs_ec2_instance_profile_role_name[0]
  policy_arn = aws_iam_policy.ecs_cross_account_s3_policy.arn
}
