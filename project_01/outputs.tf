output "vpc_id" {
  value = module.project01_vpc.id
}

output "public_subnet_id"{
  value = module.project01_vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.project01_vpc.private_subnet_id
}