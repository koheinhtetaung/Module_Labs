variable "cidr_block"{
  description ="cidr block for the vpc"
  type = string
  default = "192.168.0.0/16" 
}

variable "region" {
  type = string
  default = "ap-southeast-1"
}
variable "name" {
  type = string
  default = "project01_vpc"
}

variable "project"{
  type = string
}

variable "environment" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "public_subnet_cidr_block" {
  description = "cidr block for public subnets"
  type = list
  default = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
}

variable "private_subnet_cidr_block" {
  description = "cidr block for subnets"
  type = list
  default = ["192.168.10.0/24", "192.168.20.0/24", "192.168.30.0/24"]
}



variable "private_subnet"{
  type = string
  default = "private_subnet"
}

variable "public_subnet"{
  type = string
  default = "public_subnet"
}
variable "azs" {
  description = "Availability zone for eace subnet"
  type = list
  default = []
}

variable "bastion_ami"{
  type = string
  description = "AMI ID"
}

variable "bastion_instance_type" {
  type = string
  default = ""
}

variable "key_name" {
  type = string
  default = ""
  description = "EC2 key pair for ssh login to instances"
}

