output "word_press_sg_id" {
    value = aws_security_group.wordpress-sg.id
    description = "wordpress-security-group id"
}

output "rds_sg_id" {
    value = aws_security_group.rds-sg.id
    description = "rds-security-group id"
}

output "pub_sub" {
    value = aws_subnet.public[0].id
    description = "public subnet index id"
}

output "priv_sub" {
    value = aws_subnet.private.*.id
    description = "private subnet index id"
}