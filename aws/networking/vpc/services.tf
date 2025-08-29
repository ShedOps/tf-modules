# Internet gateway (needed for public NAT gateways route tables, not for EIP allocation itself)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.vpc_name}-igw"
    Environment = var.environment
    Provided_By = "terraform"
  }
}

# Public subnets and private subnets should be parallel lists or (better) keyed maps per AZ.
# This example assumes parallel lists: var.public_subnet_ids and var.private_subnet_cidrs
# Prefer for_each with a map if you can (see note below).
resource "aws_eip" "nat" {
  for_each   = var.default_subnets
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "natgw" {
  for_each      = var.default_subnets
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.default-public[each.key].id

  tags = {
    Name        = "${var.vpc_name}-natgw-${each.key}"
    Environment = var.environment
    Provided_By = "terraform"
  }
}
