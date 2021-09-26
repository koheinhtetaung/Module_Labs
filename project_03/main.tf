
module "network" {
  source = "../module_03"
  name = "master_vpc"
  create_vpc = true
  cidr = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {"Project" = "project_03", "Enviroment" = "Testing"}
  public_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  private_subnets = ["10.10.10.0/24", "10.10.20.0/24"]
  azs = ["ap-southeast-1b", "ap-southeast-1c"]
  create_igw = true
  providers = {
    aws = aws.igotocloud-master
   }
}