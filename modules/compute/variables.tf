variable "project_name" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "app_port" {
  type = number
}
variable "alb_security_group_id" {
  type = string
}
variable "ami_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "instance_profile_name" {
  type = string
}

variable "desired_capacity" {
  type = number
}
variable "min_size" {
  type = number
}
variable "max_size" {
  type = number
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}