module "sandbox_vpc" {
  source = "../../"

  enable_flow_logs = var.vpc_enable_flow_logs

  default_subnets = var.default_subnets

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  environment          = var.environment

  vpc_cidr_block = var.vpc_cidr_block
  vpc_name       = var.vpc_name
}
