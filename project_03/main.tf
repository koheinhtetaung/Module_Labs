
module "network" {
  source = "../module_03"
  region = "ap-southeast-1"
  create_vpc = true
  cidr = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {"Project" = "project_03", "Enviroment" = "Testing"}
  public_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  azs = ["ap-southeast-1b", "ap-southeast-1c"]
  create_igw = true
}