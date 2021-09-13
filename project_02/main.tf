module "igotocloud_infra"{
  source = "../module_02"
  name = "vpc"
  cidr = "172.21.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

}