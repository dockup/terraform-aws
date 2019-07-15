#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "dockup" {
  cidr_block = "10.0.0.0/16"

  tags = "${
    map(
      "Name", "terraform-eks-dockup-node",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_subnet" "dockup" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.dockup.id}"

  tags = "${
    map(
      "Name", "terraform-eks-dockup-node",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_internet_gateway" "dockup" {
  vpc_id = "${aws_vpc.dockup.id}"

  tags = {
    Name = "terraform-eks-dockup"
  }
}

resource "aws_route_table" "dockup" {
  vpc_id = "${aws_vpc.dockup.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dockup.id}"
  }
}

resource "aws_route_table_association" "dockup" {
  count = 2

  subnet_id      = "${aws_subnet.dockup.*.id[count.index]}"
  route_table_id = "${aws_route_table.dockup.id}"
}
