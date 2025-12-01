# terraform-module-vault-secret-sync-destination-aws
### All code is provided for reference purposes only and is used entirely at own risk. Code is for use in development environments only. Not intended for Production use. 
Terraform module for configuring HCP Vault Secrets Sync

---

##### Usage

    module "sync_destination" {
      source = "app.terraform.io/YOURORG/secret-sync-destination/vault"
      version = "1.0.0"

      name       = var.name
      env        = var.env
      role_arn   = data.aws_iam_role.aws-vault-role.arn
      mount      = module.mount-kvv2.path
      mount_id   = module.mount-kvv2.id
    }

##### Considerations
Requires an AWS keypair to be set as environment variables during the initial setup/ refresh of configuration once keys expire

## Workspace Environment Variables
```
     AWS_ACCESS_KEY_ID
     AWS_SECRET_ACCESS_KEY
```