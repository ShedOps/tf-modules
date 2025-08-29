# Public subnets: typical web-tier (can receive 80/443 traffic from the internet)
# As NACLs are stateless, we need to map the BOTH ingress/egress traffic (unlike SGs)

# PUBLIC NACL - Locked down hosted web tier
# Ingress: allow HTTP/HTTPS from anywhere
resource "aws_network_acl_rule" "public_ingress_http" {
  network_acl_id = module.sandbox_vpc.default_public_nacl_id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "public_ingress_https" {
  network_acl_id = module.sandbox_vpc.default_public_nacl_id
  rule_number    = 110
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

# Egress: allow return traffic to clients' ephemeral ports
resource "aws_network_acl_rule" "public_egress_https" {
  network_acl_id = module.sandbox_vpc.default_public_nacl_id
  rule_number    = 120
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

# PRIVATE NACL - Egress within VPC
resource "aws_network_acl_rule" "private_egress_vpc" {
  network_acl_id = module.sandbox_vpc.default_private_nacl_id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr_block
}

# Ingress within VPC (return + peer traffic)
resource "aws_network_acl_rule" "private_ingress_vpc" {
  network_acl_id = module.sandbox_vpc.default_private_nacl_id
  rule_number    = 100
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr_block
}
