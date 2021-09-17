module "igotocloud_infra"{
  source = "../module_02"
  name = "project_02_vpc"
  cidr = "172.21.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  public_subnets = ["172.21.1.0/24", "172.21.2.0/24", "172.21.3.0/24"]
  private_subnets = ["172.21.10.0/24", "172.21.20.0/24", "172.21.30.0/24"]
  azs = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  three_nat_gateway = true
  single_nat_gateway = false
  
  tags = {
    "Envrioment" = "Staging"
    "Project" = "VPC_Prj02"  
  }
}