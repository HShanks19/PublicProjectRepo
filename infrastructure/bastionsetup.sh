#! /bin/bash
sudo apt-get update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
sudo yum update -y
sudo yum install git -y
git clone https://github.com/HShanks19/BAE-sfia2-brief
sudo apt install mysql-client-core-8.0
# Code to run before snapshot created
# mysql -h ${aws_db_instance.mysqldb.address} -P 3306 -u root -ppassword <<EOF
#               CREATE DATABASE IF NOT EXISTS testdb;
#                DROP DATABASE IF EXISTS users;
#                CREATE DATABASE IF NOT EXISTS users;
#                USE users;
#                DROP TABLE IF EXISTS users;
#                CREATE TABLE users (userName VARCHAR(30) NOT NULL);
#                INSERT INTO users VALUES ('Bob'),('Jay'),('Matt'),('Ferg'),('Mo');
#                EOF>>