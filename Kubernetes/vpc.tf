data "aws_availability_zones" "aws_azs" {}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
      "Name" = "vpc-001"
    }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
      "Name" = "ig-001"
    }

}

resource "aws_subnet" "subnets" {
  count  = 2
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 1 + count.index )
  availability_zone       = element(data.aws_availability_zones.aws_azs.names, count.index)
  map_public_ip_on_launch = true
  tags = {
      "Name"                   = format("snet-public-%002d",count.index + 1)
      "kubernetes.io/role/elb" = "1"
      K8sCluster =  "cluster01"
      "kubernetes.io/cluster/cluster01" = "shared"
    }
}

resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  lifecycle {
    ignore_changes = [
      route
    ]
  }
  tags = {
      "Name" = "rt-public-001"
    }
}

resource "aws_route_table_association" "pub" {
  count          = 2
  subnet_id      = element(aws_subnet.subnets.*.id, count.index)
  route_table_id = aws_route_table.pub.id
}
