resource "aws_security_group" "murmur-server-sg" {
  name        = "murmur-server-sg"
  description = "Allow Murmur Server and SSH communication"

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Murmur TCP"
    from_port        = 64738
    to_port          = 64738
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Murmur UDP"
    from_port        = 64738
    to_port          = 64738
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MurmurServer"
  }
}