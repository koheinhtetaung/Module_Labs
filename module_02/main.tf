provider "aws" {
  region = var.region
}

#Create VPC Moudle

resource "aws_vpc" "proj_02" {
  cidr_block           = "${var.cidr}"
  instance_tenancy     = "${var.instance_tenancy}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags = merge(var.tags, tomap({"Name" = format("%s-module02",var.name)}))

}


resource "aws_subnet" "public" {
  count = "${length(var.public_subnets)}"

  vpc_id                  = "${aws_vpc.proj_02.id}"
  cidr_block              = "${var.public_subnets[count.index]}"
  availability_zone       = "${element(var.azs, count.index)}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"

  tags = merge(
    var.tags,
    var.public_subnet_tags,
    tomap({"Name"= format("%s_subnet-public-%s", var.name, element(var.azs, count.index))})
    )
}

resource "aws_subnet" "private" {
  count = "${length(var.private_subnets)}"

  vpc_id            = "${aws_vpc.proj_02.id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"

  tags = merge(
    var.tags,
    var.private_subnet_tags,
    tomap({"Name" = format("%s_subnet-private-%s", var.name, element(var.azs, count.index))})
    )
}

resource "aws_route_table" "public" {
  # count = "${length(var.public_subnets) > 0 ? 1 : 0}"

  vpc_id           = "${aws_vpc.proj_02.id}"
  # propagating_vgws = ["${var.public_propagating_vgws}"]

  tags = merge(
    var.tags,
    tomap({"Name" = format("%s-rt-public", var.name)})
    
    )
}

resource "aws_route_table_association" "public" {
  count = "${length(var.public_subnets)}"

  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}


resource "aws_internet_gateway" "prj02IGW" {
  count = "${length(var.public_subnets) > 0 ? 1 : 0}"

  vpc_id = "${aws_vpc.proj_02.id}"

   tags = merge(var.tags, tomap({"Name" = format("%s-igw",var.name)}))
}


resource "aws_route" "public_route_to_IGW" {
  count = "${length(var.public_subnets) > 0 ? 1 : 0}"

  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.prj02IGW[count.index].id}"
}



resource "aws_route_table" "private" {
  count = length(var.private_subnets)

  vpc_id           = "${aws_vpc.proj_02.id}"
  # propagating_vgws = ["${var.public_propagating_vgws}"]

  tags = merge(
    var.tags,
    tomap({"Name" = format("%s-RouteTable",var.private_subnets[count.index])})
    
    )
}

resource "aws_route_table_association" "private" {
  count = "${length(var.private_subnets)}"

  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private[count.index].id}"
}

# resource "aws_route" "private_nat_gateway" {
#   count = "${var.enable_nat_gateway ? length(var.azs) : 0}"

#   route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = "${element(aws_nat_gateway.natgw.*.id, count.index)}"
# }

# resource "aws_route_table" "private" {
#   count = "${length(var.azs)}"

#   vpc_id           = "${aws_vpc.mod.id}"
#   propagating_vgws = ["${var.private_propagating_vgws}"]

#   tags = "${merge(var.tags, map("Name", format("%s-rt-private-%s", var.name, element(var.azs, count.index))))}"
# }

# resource "aws_subnet" "private" {
#   count = "${length(var.private_subnets)}"

#   vpc_id            = "${aws_vpc.mod.id}"
#   cidr_block        = "${var.private_subnets[count.index]}"
#   availability_zone = "${element(var.azs, count.index)}"

#   tags = "${merge(var.tags, var.private_subnet_tags, map("Name", format("%s-subnet-private-%s", var.name, element(var.azs, count.index))))}"
# }