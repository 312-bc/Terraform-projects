output "ec2_ip" {
    value = aws_instance.wordpress-ec2.public_ip
    description = "public ip of wordpress instance"
}