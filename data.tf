locals {
  common_tags = {

    "Name"        = "${var.name}-${var.env}"
    "Environment" = var.env
    "Terraform"   = "true"
  }
}