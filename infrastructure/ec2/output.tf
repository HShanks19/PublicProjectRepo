output "prod_ip" {
  value = aws_instance.docker_instance.public_ip
}
output "test_ip" {
  value = aws_instance.docker_instance_test.public_ip
}
output "jenk_ip" {
  value = aws_instance.jenkins.public_ip
}
output "bast_ip" {
  value = aws_instance.bastion.public_ip
}
output "rds_endpoint" {
  value = aws_db_instance.mysqldb.endpoint
}