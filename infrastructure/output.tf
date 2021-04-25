output "production_ip" {
    value = module.ec2.prod_ip
}
output "test_ip" {
    value = module.ec2.test_ip
}
output "jenk_ip" {
    value = module.ec2.jenk_ip
}
output "bastion_ip" {
    value = module.ec2.bast_ip
}
output "rds_endpoint" {
    value = module.ec2.rds_endpoint
}