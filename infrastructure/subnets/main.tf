resource "aws_subnet" "subnet-1" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"

  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"
  tags = {
    Name = "private-subnet-1"
  }
}
resource "aws_subnet" "subnet-3" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-2c"
  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_db_subnet_group" "private" {
  name       = "private"
  subnet_ids = [ aws_subnet.subnet-2.id, aws_subnet.subnet-3.id ]

  tags = {
    Name = "private-subnet-group"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = var.route_id_public
}

resource "aws_network_interface" "web-server-nic-1" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [var.sec_group_id]
}
resource "aws_network_interface" "web-server-nic-2" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.51"]
  security_groups = [var.sec_group_id]
}
resource "aws_network_interface" "web-server-nic-3" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.52"]
  security_groups = [var.sec_group_id]
}

resource "aws_nat_gateway" "NAT_GATEWAY" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP
  ]

  allocation_id = aws_eip.Nat-Gateway-EIP.id
  
  subnet_id = aws_subnet.subnet-1.id
  tags = {
    Name = "Nat-Gateway_DB"
  }
}

resource "aws_eip" "Nat-Gateway-EIP" {
  vpc                       = true
  depends_on                = [var.internet_gate]
}

resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.NAT_GATEWAY
  ]

  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY.id
  }

  tags = {
    Name = "Route Table for NAT Gateway"
  }
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.subnet-3.id
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}