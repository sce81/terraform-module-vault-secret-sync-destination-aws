locals {
  common_tags = {

    "Name"        = "${var.name}-${var.env}"
    "Environment" = var.env
    "Terraform"   = "true"
  }
}


# Existing IAM role
data "aws_iam_role" "vault_role" {
  name = var.aws_vault_role_name
}

# Existing IAM user
data "aws_iam_user" "vault_user" {
  user_name = var.aws_vault_user_name
}

# Current AWS region
data "aws_region" "current" {}



# Trust policy for the role (who can assume it)
data "aws_iam_policy_document" "role_trust" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_iam_user.vault_user.arn]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Policy document allowing the user to assume the role
data "aws_iam_policy_document" "user_assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      data.aws_iam_role.vault_role.arn
    ]
  }
}
