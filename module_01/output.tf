output "id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id"{
  value = aws_subnet.public.*.id
}

output "private_subnet_id"{
  value = aws_subnet.private.*.id
}

output "gw_id" {
  value = aws_internet_gateway.gw.id
}

output "public_routetable_id"{
  value = aws_route_table.public.id
}

output "private_routetable_id"{
  value = aws_route_table.private.id
}

output "security_id"{
  value = aws_security_group.bastion.id
}

output "instance_id"{
  value = aws_instance.bastion.id
}
