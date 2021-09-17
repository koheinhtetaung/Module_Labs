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

#Create 3 public subnets 
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

#Create Private Subnets 
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
###################################
##   Create Public Route Table   ##
###################################
resource "aws_route_table" "public" {
  # count = "${length(var.public_subnets) > 0 ? 1 : 0}"

  vpc_id           = "${aws_vpc.proj_02.id}"
  # propagating_vgws = ["${var.public_propagating_vgws}"]

  tags = merge(
    var.tags,
    tomap({"Name" = format("%s-rt-public", var.name)})
    
    )
}

################################################
##   Public Subnets Associate to Route Table  ##
################################################

resource "aws_route_table_association" "public" {
  count = "${length(var.public_subnets)}"

  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

# Deploy Internet GateWay 
resource "aws_internet_gateway" "prj02IGW" {
  count = "${length(var.public_subnets) > 0 ? 1 : 0}"

  vpc_id = "${aws_vpc.proj_02.id}"

   tags = merge(var.tags, tomap({"Name" = format("%s-igw",var.name)}))
}


#Public Route To IGW

resource "aws_route" "public_route_to_IGW" {
  count = "${length(var.public_subnets) > 0 ? 1 : 0}"

  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.prj02IGW[count.index].id}"
}


# Deploy 3 Private Route Table 
resource "aws_route_table" "private" {
  count = length(var.private_subnets)

  vpc_id           = "${aws_vpc.proj_02.id}"
  # propagating_vgws = ["${var.public_propagating_vgws}"]

  tags = merge(
    var.tags,
    # tomap({"Name" = format("%d-RT",var.private_subnets[count.index])})
    tomap({"Name"=format("Private_RT_0%d", 1 + count.index)})
    )
}

# Each Private Subnet Route Table Association 
resource "aws_route_table_association" "private" {
  count = "${length(var.private_subnets)}"

  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private[count.index].id}"
}


resource "aws_eip" "nateip" {
  count = "${var.three_nat_gateway ? (var.single_nat_gateway ? 1 : length(var.azs)) : 0}"

  vpc = true
}

resource "aws_nat_gateway" "natgw" {
  count = "${var.three_nat_gateway ? (var.single_nat_gateway ? 1 : length(var.azs)) : 0}"

  allocation_id = "${element(aws_eip.nateip.*.id, (var.single_nat_gateway ? 0 : count.index))}"
  subnet_id     = "${element(aws_subnet.public.*.id, (var.single_nat_gateway ? 0 : count.index))}"

}

resource "aws_route" "private_nat_gateway" {
  count = "${var.three_nat_gateway ? length(var.azs) : 0}"

  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.natgw.*.id, count.index)}"
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# // Configure the EC2 instance in a public subnet
# resource "aws_instance" "ec2_public" {
#   ami                         = data.aws_ami.amazon-linux-2.id
#   associate_public_ip_address = true
#   instance_type               = "t2.micro"
#   key_name                    = var.key_name
#   subnet_id                   = var.vpc.public_subnets[0]
#   vpc_security_group_ids      = [var.sg_pub_id]

#   tags = {
#     "Name" = "${var.namespace}-EC2-PUBLIC"
#   }

#   // Configure the EC2 instance in a private subnet
# resource "aws_instance" "ec2_private" {
#   ami                         = data.aws_ami.amazon-linux-2.id
#   associate_public_ip_address = false
#   instance_type               = "t2.micro"
#   key_name                    = var.key_name
#   subnet_id                   = var.vpc.private_subnets[1]
#   vpc_security_group_ids      = [var.sg_priv_id]

#   tags = {
#     "Name" = "${var.namespace}-EC2-PRIVATE"
#   }

# }