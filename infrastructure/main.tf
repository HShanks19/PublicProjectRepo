provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}

module "vpc" {
    source          = "./vpc"
}
module "subnets" {
    source          = "./subnets"
    vpc_id          = module.vpc.vpc_id
    route_id_public = module.vpc.route_id_pub
    sec_group_id    = module.vpc.sec_group_id
    net_private_ips = ["10.0.1.50", "10.0.1.51", "10.0.1.52"]
    internet_gate   = module.vpc.internet_gate
}

module "ec2" {
    source          = "./ec2"
    net_id_prod     = module.subnets.net_id_prod
    net_id_test     = module.subnets.net_id_test
    net_id_jenk     = module.subnets.net_id_jenk
    ami_id          = var.ami_id
    instance_type   = var.instance_type
    av_zone         = var.av_zone
    key_name        = var.key_name
    sec_group_id    = module.vpc.db_sec_group_id
    subnet_group_name = module.subnets.db_subnet_group
    db_password     = var.db_password
}

resource "local_file" "tf_ansible_inventory_yaml" {
  content = <<-DOC
    all:
      children:
        jenkins:
          hosts:
            ${module.ec2.jenk_ip}:
          vars:
            ansible_ssh_private_key_file: '~/.ssh/ssh-aws-pc.pem'
            ansible_user: ubuntu
            ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
        dockerdeploy:
          hosts:
            ${module.ec2.prod_ip}:
          vars:
            ansible_ssh_private_key_file: '~/.ssh/ssh-aws-pc.pem'
            ansible_user: ubuntu
            ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
            db_ip: ${module.subnets.NAT_publicIP}
        dockertest:
          hosts:
            ${module.ec2.test_ip}:
          vars:
            ansible_ssh_private_key_file: '~/.ssh/ssh-aws-pc.pem'
            ansible_user: ubuntu
            ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
            db_ip: ${module.subnets.NAT_publicIP}
    DOC
  filename = "./ansible_files/inventory.yaml"
}

resource "local_file" "tf_daemon_json" {
  content = <<-DOC
    {
    "insecure-registries":["${module.ec2.jenk_ip}:5000"]
    }
    DOC
  filename = "./ansible_files/daemon.json"
}

resource "local_file" "instructions_next" {
  content = <<-DOC
    Following Commands to run:
    1. scp -i C:/Users/local_admin/.ssh/ssh-aws-pc.pem -r ansible_files ubuntu@${module.ec2.bast_ip}:~/.
    2. scp -i C:/Users/local_admin/.ssh/ssh-aws-pc.pem -r  C:/Users/local_admin/.ssh/ssh-aws-pc.pem ubuntu@${module.ec2.bast_ip}:~/.ssh/.
    3. ssh -i C:/Users/local_admin/.ssh/ssh-aws-pc.pem ubuntu@${module.ec2.bast_ip}
    4. cd ansible_files
    5. sh runansible.sh
    6. View Jenkins on ${module.ec2.jenk_ip}:8080 (Admin Password output to console)
      a. Set up 2 pipelines- Production_Server and Development_Server
      b. Set up global credentials for:
        - DOCKER_PASSWORD
        - SSHKey
      c. For Production_Server use /main branch and production/Jenkinsfile 
         For Development_Server use /Dev branch and development/jenkinsfile
  DOC
  filename = "./ansible_files/instructions"
}
