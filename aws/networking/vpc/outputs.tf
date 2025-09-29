# We can't use for_each on output blocks (due to expectation of a single value expression, not multiple values from iteration)
# so we will build a map / list of the values we want (which are the subnet IDs)

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

# k gives us the map key (az-a, az-b, az-c etc)
# s.id gives us the actual subnet_id, relevant to the key
output "default_private_subnet_ids" {
  description = "Map of private subnet IDs by AZ key"
  value       = { for k, s in aws_subnet.default_private : k => s.id }
}

output "default_public_subnet_ids" {
  description = "Map of public subnet IDs by AZ key"
  value       = { for k, s in aws_subnet.default_public : k => s.id }
}
