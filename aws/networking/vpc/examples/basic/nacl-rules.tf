# Define this once, so we don't duplicate rules
# We will allow all, as intended with this basic example
locals {
  # NACL Ingress - allow all
  nacl_ingress_rules = [
    {
      protocol   = -1
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]

  # NACL Egress - allow all
  nacl_egress_rules = [
    {
      protocol   = -1
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]
}

# Public NACL
resource "aws_network_acl" "public" {
  vpc_id = module.sandbox_vpc.vpc_id

  dynamic "ingress" {
    for_each = local.nacl_ingress_rules
    content {
      protocol   = ingress.value.protocol
      rule_no    = ingress.value.rule_no
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = local.nacl_egress_rules
    content {
      protocol   = egress.value.protocol
      rule_no    = egress.value.rule_no
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }
}

resource "aws_network_acl_association" "public_ingress" {
  for_each = module.sandbox_vpc.default_public_subnet_ids

  network_acl_id = aws_network_acl.public.id
  subnet_id      = each.value
}

# Private NACL
resource "aws_network_acl" "private" {
  vpc_id = module.sandbox_vpc.vpc_id

  dynamic "ingress" {
    for_each = local.nacl_ingress_rules
    content {
      protocol   = ingress.value.protocol
      rule_no    = ingress.value.rule_no
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = local.nacl_egress_rules
    content {
      protocol   = egress.value.protocol
      rule_no    = egress.value.rule_no
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }
}

resource "aws_network_acl_association" "private_egress" {
  for_each = module.sandbox_vpc.default_private_subnet_ids

  network_acl_id = aws_network_acl.private.id
  subnet_id      = each.value
}
