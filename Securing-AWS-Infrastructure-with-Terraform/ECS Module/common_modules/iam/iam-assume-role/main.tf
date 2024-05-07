data "aws_iam_policy_document" "assume_role_policy" {
  count = var.role_enabled ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    dynamic "principals" {
      for_each = var.principals

      content {
        type        = principals.value.type
        identifiers = principals.value.identifiers
      }
    }
  }
}

resource "aws_iam_role" "assume_role" {
  count = var.role_enabled ? 1 : 0

  name               = var.role_name
  assume_role_policy = join("", data.aws_iam_policy_document.assume_role_policy.*.json)
  path               = var.role_path

  tags = var.role_tags
}

resource "aws_iam_role_policy_attachment" "policy_attachments" {
  for_each = toset(var.role_enabled ? var.attachable_policy_arns : [])

  role       = join("", aws_iam_role.assume_role.*.name)
  policy_arn = each.value
}
