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

output "eip_id"{
  value = ["${aws_eip.nateip.*.id}"]
}

output "nat_gateway_id" {
  value = aws_nat_gateway.natgw.*.id
}

output "nat_gateway_address" {
  value = aws_nat_gateway.natgw.*.subnet_id
}

output "sg_pub_id" {
  value = aws_security_group.allow_ssh_pub.id
}

output "sg_priv_id" {
  value = aws_security_group.allow_ssh_priv.id
}

output "public_ip" {
  value = aws_instance.ec2_public.public_ip
}

output "private_ip" {
  value = aws_instance.ec2_private.private_ip
}