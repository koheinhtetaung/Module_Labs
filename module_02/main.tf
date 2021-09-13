provider "aws" {
  region = var.region
}

#Create VPC Moudle

resource "aws_vpc" "proj_02" {
  cidr_block           = "${var.cidr}"
  instance_tenancy     = "${var.instance_tenancy}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags = merge(var.tags, tomap({"Name" = format("%s-module02",var.name)}))

}