output "wordpress_ec2_ip" {
    value = module.ec2-wordpress.ec2_ip
    description = "public ip of wordpress instance"
}

output "rds_endpoint" {
    value = module.mysql-db.rds_endpoint
    description = "rds instance endpoint"
}