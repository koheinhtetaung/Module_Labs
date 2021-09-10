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

