output "vpc_id" {
  value = module.sandbox_vpc.vpc_id
}

output "default_private_subnet_ids" {
  value = module.sandbox_vpc.default_private_subnet_ids
}

output "default_public_subnet_ids" {
  value = module.sandbox_vpc.default_public_subnet_ids
}
