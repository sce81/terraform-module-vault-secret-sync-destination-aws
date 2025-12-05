variable "name" {
  type        = string
  description = "Name for tagging purposes"
}
variable "env" {
  type        = string
  description = "Environment name for tagging purposes"
}

variable "role_name" {
  type        = string
  description = "AWS IAM Role ARN to for Vault to use to manage the synced secret"
}
variable "user_name" {
  type        = string
  description = "AWS IAM Role ARN to for Vault to use to manage the synced secret"
}
variable "extra_tags" {
  type    = map(any)
  default = {}
}

variable "mount" {
  description = "Mount path for the KVV2 engine in Vault without trailing or leading slashes."
  type        = string
  default     = "kvv1"
}

variable "mount_id" {
  description = "the auth backend to authenticate against"
  type        = string
  default     = null
}


variable "aws_vault_role_name" {
  type        = string
  default     = "hcp-vault"
  description = "Name of IAM role associated with Vault"
}

variable "aws_vault_user_name" {
  type        = string
  default     = "HCP-Vault-Secrets-Sync"
  description = "Name of IAM role associated with Vault"
}

variable "access_key_id" {
  type      = string
  sensitive = true
}

variable "secret_access_key" {
  type      = string
  sensitive = true
}
