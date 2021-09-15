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