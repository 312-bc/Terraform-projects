variable "rds_instance_root" {
    type = string
    description = "rds instance type"
}

variable "rds_username_root" {
    type = string
    description = "rds instance username"
}

variable "rds_password_root" {
    type = string
    description = "rds instance password"
}

variable "vpc_cidr_root" {
    type = string
    description = "vpc cidr block"
}

variable "public_subnets_range_root" {
    type = list
    description = "private_subnets cidr"
}

variable "private_subnets_range_root" {
    type = list
    description = "private_subnets cidr"
}

variable "availability_zones_root" {
    type = list
    description = "availability zones"
}

variable "open_cidr_root" {
    type = string
    description = "open cidr range"
}

variable "open_cidr_ipv6_root" {
    type = string
    description = "open cidr range"
}

variable "ec2_type_root" {
    type = string
    description = "public subnet id"
}

variable "ssh_key_name_pub_root" {
    type = string
    description = "ssh key public"
}

variable "ssh_key_name_priv_root" {
    type = string
    description = "ssh key private"
}

variable "ec2_ami_root" {
    type = string
    description = "ec2 ami id"
}

variable "rds_name_root" {
    type = string
    description = "rds instance name"
}