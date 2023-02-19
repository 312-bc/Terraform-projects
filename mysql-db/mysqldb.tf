resource "aws_db_instance" "mysql" {
  allocated_storage = 20
  engine           = "mysql"
  engine_version   = "5.7"
  instance_class   = var.rds_instance
  name             = var.rds_name
  username         = var.rds_username
  password         = var.rds_password
  storage_type     = "gp2"
  skip_final_snapshot  = true
  vpc_security_group_ids = [var.rds_sg_id]
  db_subnet_group_name   = aws_db_subnet_group.private.name
  tags = {
    Name = "wordpress-rds"
  }
}

resource "aws_db_subnet_group" "private" {
  name       = "private-db-subnet-group"
  subnet_ids = tolist(var.private_subnets_ids)
}

#user - admin
#password - adminadmin
##user - wordpress
##password - wordpress-pass
