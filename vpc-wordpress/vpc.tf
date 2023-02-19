resource "aws_vpc" "wordpress-vpc" {
  enable_dns_hostnames = true
  enable_dns_support = true
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "wordpress-vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets_range)
  vpc_id     = aws_vpc.wordpress-vpc.id
  cidr_block = var.public_subnets_range[count.index]
  map_public_ip_on_launch = true
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "public${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets_range)
  vpc_id     = aws_vpc.wordpress-vpc.id
  cidr_block = var.private_subnets_range[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "private${count.index}"
  }
}

resource "aws_internet_gateway" "wordpress_igw" {
  vpc_id = aws_vpc.wordpress-vpc.id
  tags = {
    Name = "wordpress_igw"
  }
}

resource "aws_eip" "wordpress_ngw" {
  vpc = true 
  }

resource "aws_nat_gateway" "wordpress_ngw" {
  allocation_id = aws_eip.wordpress_ngw.id
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = "wordpress_NAT"
  }
depends_on = [aws_internet_gateway.wordpress_igw]
}

resource "aws_route_table" "wordpess-rt-pub" {
  vpc_id = aws_vpc.wordpress-vpc.id
  route {
    cidr_block = var.open_cidr
    gateway_id = aws_internet_gateway.wordpress_igw.id
  }
  tags = {
    Name = "wordpess-rt-pub"
  }
}

resource "aws_route_table" "wordpess-rt-priv" {
  vpc_id = aws_vpc.wordpress-vpc.id
  route {
    cidr_block = var.open_cidr
    gateway_id = aws_nat_gateway.wordpress_ngw.id
  }
  tags = {
    Name = "wordpess-rt-priv"
  }
}

resource "aws_route_table_association" "pub" {
  count = length(var.public_subnets_range)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.wordpess-rt-pub.id
}

resource "aws_route_table_association" "priv" {
  count = length(var.private_subnets_range)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.wordpess-rt-priv.id
}

resource "aws_security_group" "wordpress-sg" {
  name        = "wordpress-sg"
  description = "Allows HTTP, HTTPS, SSH"
  vpc_id      = aws_vpc.wordpress-vpc.id
  dynamic "ingress" {
    for_each = {"HTTP" = 80, "HTTPS" = 443, "SSH" = 22}
    content {
        description      = "${ingress.key} from VPC"
        from_port        = ingress.value
        to_port          = ingress.value
        protocol         = "tcp"
        cidr_blocks      = [var.open_cidr]
    }
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.open_cidr]
  }
  tags = {
    Name = "wordpress-sg"
  }
}

resource "aws_security_group" "rds-sg" {
  name        = "rds-sg"
  description = "Allows HTTP, HTTPS, SSH"
  vpc_id      = aws_vpc.wordpress-vpc.id
  ingress {
    description      = "MYSQL from SG"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.wordpress-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.open_cidr]
  }
  tags = {
    Name = "rds-sg"
  }
}