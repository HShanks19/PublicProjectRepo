output "vpc_id" {
    value = aws_vpc.prod-vpc.id
}
output "route_id_pub" {
    value = aws_route_table.prod-route-table.id
}

output "sec_group_id" {
    value = aws_security_group.allow_web.id
}
output "db_sec_group_id" {
    value = aws_security_group.MySQL-SG.id
}
output "internet_gate" {
    value = aws_internet_gateway.gw
}