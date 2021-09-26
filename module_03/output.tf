output "vpc_id" {
  value = aws_vpc.mastervpc.*.id
}

output "public_subnets_id" {
  value = aws_subnet.public.*.id
}

output "private_subnets_id" {
  value = aws_subnet.private.*.id
}

output "igw_id" {
  value = aws_internet_gateway.IGW.*.id
}