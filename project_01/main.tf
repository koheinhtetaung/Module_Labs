module "project01_vpc" {
  source = "../../modules/module-01"

  name = "project01_vpc"
  cidr_block = "192.168.0.0/16"
  region = "ap-southeast-1"
  project = "vpc1_project"
  environment = "testing"
  public_subnet_cidr_block = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  private_subnet_cidr_block = ["192.168.10.0/24", "192.168.20.0/24", "192.168.30.0/24"]
  azs = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}