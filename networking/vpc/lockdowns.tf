# Locks down default resources for tight control - this is useful to prevent accidental exposure
# if soneone forgets an association (we land in a deny-by-default posture).
resource "aws_default_security_group" "locked-default-sg" {
  vpc_id = aws_vpc.vpc.id

  # We deny ALL traffic by omitting any ingress/egress rules

  tags = {
    Name        = "do-not-use (default SG)"
    Created_by  = "Terraform"
    Environment = var.environment
  }
}

# We leave the default NACL unassociated with any subnets
# ...and add deny-all
resource "aws_default_network_acl" "locked-default-nacl" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id
  subnet_ids             = []

  # We deny ALL traffic by omitting any ingress/egress rules

  tags = {
    Name        = "do-not-use (default NACL)"
    Created_By  = "Terraform"
    Environment = var.environment
  }
}
