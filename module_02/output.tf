output "vpc_id" {
  value = aws_vpc.proj_02.id
}

output "igw_id" {
  value = aws_internet_gateway.prj02IGW.*.id
}

output "public_subnets_id" {
  value = aws_subnet.public.*.id
}

output "private_subnets_id" {
  value = aws_subnet.private.*.id
}

output "rt_id"{
  value = aws_route_table.public.id
}

output "private_rt_id" {
  value = aws_route_table.private.*.id
}
