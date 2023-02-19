variable "ec2_type" {
    type = string
    description = "ec2 type info"
}

variable "ssh_key_name_pub" {
    type = string
    description = "public key local"
}

variable "ssh_key_name_priv" {
    type = string
    description = "private key local"
}

variable "ec2_ami" {
    type = string
    description = "ec2 ami id"
}

variable "word_press_sg_id" {
    type = string
    description = "wordpress-security-group id"
}

variable "pub_sub" {
    type = string
    description = "public subnet id"
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

variable "rds_endpoint" {
    type = string
    description = "rds instance endpoint"
}