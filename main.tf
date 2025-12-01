resource "vault_secrets_sync_aws_destination" "aws" {
  name                 = "aws-secrets-sync-${var.name}-${var.env}"
  role_arn             = var.role_arn
  secret_name_template = "vault_${var.name}-{{ .MountAccessor | lowercase }}_{{ .SecretPath | lowercase }}"
  custom_tags = merge(
    local.common_tags, var.extra_tags,
    tomap({
      Name = "${var.name}-${var.env}"
    })
  )
}


resource "vault_kv_secret_v2" "db_secret" {
  mount    = var.mount
  //mount_id = var.mount_id
  name     = "${var.name}-${var.env}-secrets-sync"
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