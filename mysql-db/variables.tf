variable "rds_sg_id" {
    type = string
    description = "rds-security-group id"
}

variable "private_subnets_range_mysql" {
    type = list
    description = "private_subnets cidr"
}

variable "rds_instance" {
    type = string
    description = "rds instance type"
}

variable "rds_username" {
    type = string
    description = "rds instance username"
}

variable "rds_password" {
    type = string
    description = "rds instance password"
}

variable "rds_name" {
    type = string
    description = "rds instance name"
}

variable "private_subnets_ids" {
    type = list
    description = "private_subnets ids"
}