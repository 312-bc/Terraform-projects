#!/bin/bash
rds_username=${rds_username}
rds_password=${rds_password}
rds_endpoint=${rds_endpoint}
rds_name=${rds_name}

# Installation apache server and mysql
yum update -y 
yum install -y httpd
yum install -y mysql

export MYSQL_HOST=${rds_endpoint}


# Connection to MySQL
mysql --user=${rds_username} --password=${rds_password} ${rds_name} <<EOFMYSQL
    CREATE USER 'wordpress' IDENTIFIED BY 'wordpress-pass';
    GRANT ALL PRIVILEGES ON wordpress.* TO wordpress;
    FLUSH PRIVILEGES;
    Exit
EOFMYSQL

# Configurations of Wordpress on ec2
systemctl httpd start

#  Downloading and configuration Wordpress
cd /home/ec2-user
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz

cd /home/ec2-user/wordpress
cp wp-config-sample.php wp-config.php

# Changing default text to the needed values
sed -i "s/database_name_here/${rds_name}/g" wp-config.php
sed -i "s/username_here/${rds_username}/g" wp-config.php
sed -i "s/password_here/${rds_password}/g" wp-config.php
sed -i "s/localhost/${rds_endpoint}/g" wp-config.php

# Downloading wordpress secret key api and inserting them into a configuration file
curl -s https://api.wordpress.org/secret-key/1.1/salt/ > keys-file.txt
sed -i '51,58d' wp-config.php
sed -i '51r keys-file.txt' wp-config.php

# Deploying Wordpress

amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2

cd /home/ec2-user
cp -r wordpress/* /var/www/html/
service httpd restart