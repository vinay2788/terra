data "aws_vpc" "default" {
  default = true
}
resource "aws_security_group" "test" {
  name        = "test"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.test.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.test.id
  cidr_ipv6         = "::/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.test.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp" # semantically equivalent to all ports
  from_port = 3000
  to_port = 3000
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.test.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "tcp" # semantically equivalent to all ports
  from_port = 4000
  to_port = 4000
}
resource "aws_vpc_security_group_ingress_rule" "allow_all_traffic_ipv4" {
    security_group_id = aws_security_group.test.id
    cidr_ipv4         = "10.0.0.0/16"
    from_port         = 5000
    to_port           = 5000
    ip_protocol       = "tcp"
  
}