resource "aws_instance" "docker_instance" {
  ami               = var.ami_id 
  instance_type     = var.instance_type 
  availability_zone = var.av_zone 
  key_name          = var.key_name
   user_data = <<-EOF
                #!/bin/bash
                echo "export DB_PWD="password"">>~/.bashrc
                echo "DB_PWD="password"">>~/.profile
                echo "DB_PWD="password"">>/etc/environment
                source ~/.bashrc
                source ~/.profile
                EOF
  
  network_interface {
    device_index         = 0
    network_interface_id = var.net_id_prod
  }
  tags = {
    Name = "deploy"
  }
}
resource "aws_instance" "docker_instance_test" {
  ami               = var.ami_id 
  instance_type     = var.instance_type 
  availability_zone = var.av_zone 
  key_name          = var.key_name
  user_data = <<-EOF
                #!/bin/bash
                echo "export DB_PWD="password"">>~/.bashrc
                echo "DB_PWD="password"">>~/.profile
                echo "DB_PWD="password"">>/etc/environment
                source ~/.bashrc
                source ~/.profile
                EOF
  
  network_interface {
    device_index         = 0
    network_interface_id = var.net_id_test
  }
  tags = {
    Name = "test"
  }
}
resource "aws_instance" "jenkins" {
  ami               = var.ami_id 
  instance_type     = var.instance_type 
  availability_zone = var.av_zone 
  key_name          = var.key_name

  network_interface {
    device_index         = 0
    network_interface_id = var.net_id_jenk
  }

  tags = {
    Name = "jenkins"
  }
}

resource "aws_instance" "bastion" {
  ami               = var.ami_id 
  instance_type     = var.instance_type 
  availability_zone = var.av_zone 
  key_name          = var.key_name
  depends_on = [
    aws_db_instance.mysqldb
  ]
  user_data = file("C:/Users/local_admin/Terraform/terraform/bastionsetup.sh")

  tags = {
    Name = "bastion"
  }

}


resource "aws_db_instance" "mysqldb" {
  identifier             = "mysqldb"
  name                   = "users"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "mysql"
  engine_version         = "5.7"
  username               = "root"
  password               = var.db_password
  db_subnet_group_name   = var.subnet_group_name
  vpc_security_group_ids = [var.sec_group_id]
  parameter_group_name   = "default.mysql5.7"
  publicly_accessible    = false
  skip_final_snapshot    = true
  snapshot_identifier    = "mysqldbsetup"
}