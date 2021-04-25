output "NAT_publicIP" {
  value = aws_eip.Nat-Gateway-EIP.public_ip
}
output "net_id_prod" {
  value = aws_network_interface.web-server-nic-1.id
}
output "net_id_test" {
  value = aws_network_interface.web-server-nic-2.id
}
output "net_id_jenk" {
  value = aws_network_interface.web-server-nic-3.id
}
output "db_subnet_group" {
  value = aws_db_subnet_group.private.name
}