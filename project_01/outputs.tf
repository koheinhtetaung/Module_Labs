output "vpc_id" {
  value = module.project01_vpc.id
}

output "public_subnet_id"{
  value = module.project01_vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.project01_vpc.private_subnet_id
}

output "igw_id" {
  value = module.project01_vpc.gw_id
}

output "pub_route_table_id" {
  value = module.project01_vpc.public_routetable_id
}

output "private_route_table_id" {
  value = module.project01_vpc.private_routetable_id
}