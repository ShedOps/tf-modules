data "aws_region" "current" {}

resource "aws_vpc" "sandbox" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  instance_tenancy     = "default"

  tags = {
    Name               = var.name
    Created_by         = "Terraform"
    Environment        = var.env
  }
}
