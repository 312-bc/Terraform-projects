module "vpc-wordpress" {
    source = "../vpc-wordpress"
    vpc_cidr = var.vpc_cidr_root
    public_subnets_range = var.public_subnets_range_root
    availability_zones = var.availability_zones_root
    private_subnets_range = var.private_subnets_range_root
    open_cidr = var.open_cidr_root
    open_cidr_ipv6 = var.open_cidr_ipv6_root
}

module "mysql-db" {
    source = "../mysql-db"
    rds_sg_id = module.vpc-wordpress.rds_sg_id
    private_subnets_range_mysql = var.private_subnets_range_root
    private_subnets_ids = module.vpc-wordpress.priv_sub
    rds_instance = var.rds_instance_root
    rds_username = var.rds_username_root
    rds_password = var.rds_password_root
    rds_name = var.rds_name_root
}

module "ec2-wordpress" {
    source = "../ec2-wordpress"
    word_press_sg_id = module.vpc-wordpress.word_press_sg_id
    pub_sub = module.vpc-wordpress.pub_sub
    ec2_type = var.ec2_type_root
    ssh_key_name_pub = var.ssh_key_name_pub_root
    ssh_key_name_priv = var.ssh_key_name_priv_root
    ec2_ami = var.ec2_ami_root
    rds_username = var.rds_username_root
    rds_password = var.rds_password_root
    rds_endpoint = module.mysql-db.rds_endpoint
    rds_name = var.rds_name_root
}
