resource "vault_secrets_sync_aws_destination" "aws" {
  name              = "aws-secrets-sync-${var.name}-${var.env}"
  access_key_id     = var.access_key_id
  secret_access_key = var.secret_access_key
  region            = data.aws_region.current.region
  //role_arn             = data.aws_iam_role.vault_role.arn
  secret_name_template = "vault_${var.name}-{{ .MountAccessor | lowercase }}_{{ .SecretPath | lowercase }}"
  custom_tags = merge(
    local.common_tags, var.extra_tags,
    tomap({
      Name = "${var.name}-${var.env}"
    })
  )
}

resource "vault_kv_secret_v2" "main" {
  mount = var.mount
  //mount_id = var.mount_id
  name = "${var.name}-${var.env}-secrets-sync"
  data_json_wo = jsonencode(
    {
      secret = ephemeral.random_password.main.result
    }
  )
}

ephemeral "random_password" "main" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "vault_secrets_sync_association" "main" {
  name        = vault_secrets_sync_aws_destination.aws.name
  type        = vault_secrets_sync_aws_destination.aws.type
  mount       = var.mount
  secret_name = vault_kv_secret_v2.main.name
}



# Create IAM policy for the user
resource "aws_iam_policy" "user_assume_role_policy" {
  name        = "${var.aws_vault_user_name}-AssumeRole"
  description = "Allows ${var.aws_vault_user_name} to assume ${var.aws_vault_role_name}"
  policy      = data.aws_iam_policy_document.user_assume_role.json
}

# Attach the policy to the IAM user
resource "aws_iam_user_policy_attachment" "attach_assume_role" {
  user       = data.aws_iam_user.vault_user.user_name
  policy_arn = aws_iam_policy.user_assume_role_policy.arn
}




