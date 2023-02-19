variable "vpc_cidr" {
    type = string
    description = "vpc cidr block"
}

variable "open_cidr" {
    type = string
    description = "open cidr range"
}

variable "open_cidr_ipv6" {
    type = string
    description = "open cidr range"
}

variable "public_subnets_range" {
    type = list
    description = "public_subnets cidr"
}

variable "private_subnets_range" {
    type = list
    description = "private_subnets cidr"
}

variable "availability_zones" {
    type = list
    description = "availability zones"
}
