#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "eks-cluster" {
  cidr_block = "10.0.0.0/16"

  tags = "${
    map(
      "Name", "tf-${var.cluster-name}",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_subnet" "eks-cluster" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.eks-cluster.id}"

  tags = "${
    map(
      "Name", "tf-${var.cluster-name}",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_internet_gateway" "eks-cluster" {
  vpc_id = "${aws_vpc.eks-cluster.id}"

  tags = {
    Name = "tf-${var.cluster-name}"
  }
}

resource "aws_route_table" "eks-cluster" {
  vpc_id = "${aws_vpc.eks-cluster.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.eks-cluster.id}"
  }
}

resource "aws_route_table_association" "eks-cluster" {
  count = 2

  subnet_id      = "${aws_subnet.eks-cluster.*.id[count.index]}"
  route_table_id = "${aws_route_table.eks-cluster.id}"
}
