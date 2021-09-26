# variable "region" {
#   type = string
#   default = ""
#   description = "User must input which region want to lunch your resources"
# }

variable "create_vpc" {
  type = bool
  default = "false"
  description = "This condition should be true, if you want to create vpc"
}

variable "cidr" {
  type = string
  default = ""
  description = "User must input cidr block in vpc. eg 192.168.0.0/16"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}

variable "name" {
  type = string
  default = ""
  description = "will apply all resources"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC."
  default     = []
}
variable "create_igw" {
  type = bool
  default = true
}
variable "azs" {
  description = "A list of Availability zones in the region"
  default     = []
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "public"
}

variable "map_public_ip_on_launch" {
  type = bool
  default = true
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  default     = []
}

variable "private_subnet_suffix" {
  type = string
  default = "private"
}