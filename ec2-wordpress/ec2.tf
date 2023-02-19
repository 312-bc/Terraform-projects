resource "aws_key_pair" "wordpress_key_pub" {
  key_name   = "wordpress-key_pub"
  public_key = file(var.ssh_key_name_pub)
}

resource "aws_instance" "wordpress-ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  key_name   = aws_key_pair.wordpress_key_pub.id
  vpc_security_group_ids = [var.word_press_sg_id]
  subnet_id = var.pub_sub

  user_data = templatefile("/Users/petrovich/else/terraform/wordpress/ec2-wordpress/user_data.tpl",{rds_username = var.rds_username,rds_password = var.rds_password,rds_endpoint = var.rds_endpoint,rds_name = var.rds_name})

  tags = {
    Name = "wordpress-ec2"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.ssh_key_name_priv)
    host        = aws_instance.wordpress-ec2.public_ip
  }
}

