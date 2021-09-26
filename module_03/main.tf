# provider "aws"{
#   region = var.region  
# }



resource "aws_vpc" "mastervpc" {
  count = var.create_vpc ? 1 : 0

  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}

resource "aws_internet_gateway" "IGW" {
  count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.mastervpc[0].id

  tags = merge(
    {
      "Name" = format("%s-igw", var.name)
    },
    var.tags,

  )
}

resource "aws_subnet" "public" {
  count = var.create_vpc ? length(var.public_subnets) : 0

  vpc_id                          = aws_vpc.mastervpc[0].id
  cidr_block                      = element(var.public_subnets, count.index)
  availability_zone               = element(var.azs, count.index)
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  tags = merge(
    {
      "Name" = format(
        "%s-${var.public_subnet_suffix}-%s",
        var.name,
        element(var.azs, count.index),
      )
    },
    var.tags,

  )
}

resource "aws_subnet" "private" {
  count = var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  vpc_id                          = aws_vpc.mastervpc[0].id
  cidr_block                      = var.private_subnets[count.index]
  availability_zone               = length(regexall("[a-z]+", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  # availability_zone_id            = length(regexall("[a-z]+", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  # assign_ipv6_address_on_creation = var.private_subnet_assign_ipv6_address_on_creation == null ? var.assign_ipv6_address_on_creation : var.private_subnet_assign_ipv6_address_on_creation

  # ipv6_cidr_block = var.enable_ipv6 && length(var.private_subnet_ipv6_prefixes) > 0 ? cidrsubnet(aws_vpc.this[0].ipv6_cidr_block, 8, var.private_subnet_ipv6_prefixes[count.index]) : null

  tags = merge(
    {
      "Name" = format(
        "%s-${var.private_subnet_suffix}-%s",
        var.name,
        element(var.azs, count.index),
      )
    },
    var.tags,
  )
}