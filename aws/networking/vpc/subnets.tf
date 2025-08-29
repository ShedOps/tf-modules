#--- DEFAULT PUBLIC SUBNET
resource "aws_subnet" "default_public" {
  vpc_id   = aws_vpc.vpc.id
  for_each = var.default_subnets

  cidr_block              = each.value.default_public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[index(keys(var.default_subnets), each.key)]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name        = "${var.vpc_name}-public-${each.key}"
    Environment = var.environment
    Provided_By = "terraform"
  }
}

resource "aws_network_acl" "default_public_nacl" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-default-public-nacl"
  }
}

resource "aws_network_acl_association" "default_public_nacl_assoc" {
  for_each       = aws_subnet.default_public
  subnet_id      = each.value.id
  network_acl_id = aws_network_acl.default_public_nacl.id
}

resource "aws_default_route_table" "public" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = {
    Name        = "${var.vpc_name}-default_public_routetable"
    Environment = var.environment
    Provided_By = "terraform"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_default_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_vpc.vpc]
}

resource "aws_route_table_association" "public_rta" {
  for_each = var.default_subnets

  subnet_id      = aws_subnet.default_public[each.key].id
  route_table_id = aws_default_route_table.public.id
}


#--- DEFAULT PRIVATE SUBNET
resource "aws_subnet" "default_private" {
  vpc_id   = aws_vpc.vpc.id
  for_each = var.default_subnets

  cidr_block              = each.value.default_private_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[index(keys(var.default_subnets), each.key)]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.vpc_name}-private-${each.key}"
    Environment = var.environment
    Provided_By = "terraform"
  }
}

resource "aws_network_acl" "default_private_nacl" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-default-private-nacl"
  }
}

resource "aws_network_acl_association" "default_private_nacl_assoc" {
  for_each       = aws_subnet.default_private
  subnet_id      = each.value.id
  network_acl_id = aws_network_acl.default_private_nacl.id
}

resource "aws_route_table" "private" {
  for_each = var.default_subnets

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.vpc_name}-private-rt-${each.key}"
    Environment = var.environment
    Provided_By = "terraform"
  }
}

resource "aws_route" "private_route" {
  for_each = var.default_subnets

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw[each.key].id
  depends_on             = [aws_route_table.private]
}

resource "aws_route_table_association" "private_rta" {
  for_each = var.default_subnets

  subnet_id      = aws_subnet.default_private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}
