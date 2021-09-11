provider "aws"{
  region = var.region
  
}


resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Name        = var.name,
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}


resource "aws_subnet" "public" {
  count = length (var.public_subnet_cidr_block)

  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr_block[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name        = var.public_subnet,
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
  
}

resource "aws_subnet" "private" {
  count = length (var.private_subnet_cidr_block)

  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr_block[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    {
      Name        = var.private_subnet,
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
  
}

#Internet Gateway for Project01_vpc

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      Name        = "gwInternet",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}

#Route Table for Public_ subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      Name        = "PublicRouteTable",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}

#Default route gateway to IGW. 

resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
}

#Route Table Association in Public_Route Table 

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_block)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# resource "aws_route" "private" {
#   count = length(var.private_subnet_cidr_block)

#   route_table_id         = aws_route_table.private[count.index].id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.default[count.index].id
# }

resource "aws_route_table" "private" {
  # count = var.route_table_number

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      Name        = "PrivateRouteTable",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}

#Route Table Association in Private_Route Table 

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr_block)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}