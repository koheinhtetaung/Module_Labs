output "vpc_id" {
  value = module.igotocloud_infra.vpc_id
}


output "igw_id" {
  value = module.igotocloud_infra.igw_id
}

output "public_subnets_id" {
  value = module.igotocloud_infra.public_subnets_id
}

output "private_subnets_id" {
  value = module.igotocloud_infra.private_subnets_id
}

output "route_table_id" {
  value = module.igotocloud_infra.rt_id
}

output "private_rt_id"{
  value = module.igotocloud_infra.private_rt_id
}

output "eip_id"{
  value = module.igotocloud_infra.eip_id
}

output "nat_gateway_id" {
  value = module.igotocloud_infra.nat_gateway_id
}

# output "nat_gatway_address"{
#   value = module.igotocloud_infra.nat_gateway_address
# }

# output "sg_pub_id" {
#   value = module.igotocloud_infra.sg_pub_id
# }

# output "sg_priv_id" {
#   value = module.igotocloud_infra.sg_priv_id
# }

# output "ssh_public_instance" {
#   value = "ssh -i SGkey.pem ec2-user@${module.igotocloud_infra.public_ip}"
# }

# output "ssh_private_instance" {
#   value = "ssh -i SGkey.pem ec2-user@${module.igotocloud_infra.private_ip}"
# }
