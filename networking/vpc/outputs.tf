# We can't use for_each on output blocks (due to expectation of a single value expression, not multiple values from iteration)
# so we will build a map / list of the values we want (which are the subnet IDs)

output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The ID of the VPC"
}

# k gives us the map key (az-a, az-b, az-c etc)
# s.id gives us the actual subnet_id, relevant to the key
output "default_private_subnet_ids" {
  description = "Map of private subnet IDs by AZ key"
  value       = { for k, s in aws_subnet.default-private : k => s.id }
}

output "default_public_subnet_ids" {
  description = "Map of public subnet IDs by AZ key"
  value       = { for k, s in aws_subnet.default-public : k => s.id }
}
