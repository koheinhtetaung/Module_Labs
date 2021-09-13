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