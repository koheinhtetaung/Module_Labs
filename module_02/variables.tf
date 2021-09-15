variable "region"{
  type = string
  default = "ap-southeast-1"
  description = "Resources willl create region that you define"
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default = ""
}

variable "cidr"{
  type = string
  default = "10.0.0.0/16"
  description = " cidr block for vpc "
}

variable "instance_tenancy" {
  type = string
  default = "default"

}

variable "enable_dns_hostnames" {
  default = true
}

variable "enable_dns_support" {
  default = true
}



variable "tags" {
  type = map(string)
  default = {}
}

variable "public_subnets" {
  type = list
  default = ["172.21.1.0/24", "172.21.2.0/24", "172.21.3.0/24"]
}

variable "azs" {
  description = "A list of Availability zones in the region"
  default     = []
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  default     = {}
}


variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

variable "private_subnets" {
  description = "private subnets list"
  type = list
  default = []

}

variable "private_subnet_tags" {
  description = "additional tags for the private subnets"
  type = map(string)
  default =  {}
}

# variable "public_propagating_vgws" {
#   description = "A list of VGWs the public route table should propagate."
#   default     = ["aws_internet_gateway"]
# }