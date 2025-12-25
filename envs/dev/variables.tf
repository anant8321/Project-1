variable "aws_region" {
  type = string
  description = "AWS Region"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR for the VPC"
}

variable "vpc_name" {
  type = string
  description = "Name of the VPC"
}

variable "public_sub_cidrs" {
  description = "list of all public subnet cidrs"
  type = list(string)
}
variable "az_list" {
  description = "list of being used availability zones"
  type = list(string)
}
variable "private_sub_cidrs" {
  description = "list of all private subnet cidrs"
  type = list(string)
}