resource "aws_subnet" "pubsub1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name                                                 = "pubsub1"
    "kubernetes.io/cluster/demo" = "shared"
    "kubernetes.io/role/elb"                             = 1
  }
}

resource "aws_subnet" "privsub1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name                                                 = "privsub1"
    "kubernetes.io/cluster/demo" = "shared"
    "kubernetes.io/role/elb"                             = 1
  }
}

resource "aws_subnet" "pubsub2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name                                                 = "pubsub2"
    "kubernetes.io/cluster/demo" = "shared"
    "kubernetes.io/role/elb"                             = 1
  }
}

resource "aws_subnet" "privsub2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name                                                 = "privsub2"
    "kubernetes.io/cluster/demo" = "shared"
    "kubernetes.io/role/elb"                             = 1
  }
}