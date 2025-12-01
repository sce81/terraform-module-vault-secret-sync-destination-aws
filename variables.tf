variable "name" {
  type        = string
  description = "Name for tagging purposes"
}
variable "env" {
  type        = string
  description = "Environment name for tagging purposes"
}
variable "role_arn" {
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
  default     = "kvv2"
}

variable "mount_id" {
  description = "the auth backend to authenticate against"
  type        = string
  default     = null
}