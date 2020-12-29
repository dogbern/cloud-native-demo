# Elastic IPs to associate with NAT Gateways
resource "aws_eip" "nat1" {
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat2" {
  depends_on = [aws_internet_gateway.igw]
}

# NAT Gateways in the Public Subnets
resource "aws_nat_gateway" "gw1" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.pubsub1.id

  tags = {
    Name = "gw1 NAT"
  }
}

resource "aws_nat_gateway" "gw2" {
  allocation_id = aws_eip.nat2.id
  subnet_id     = aws_subnet.pubsub2.id

  tags = {
    Name = "gw2 NAT"
  }
}