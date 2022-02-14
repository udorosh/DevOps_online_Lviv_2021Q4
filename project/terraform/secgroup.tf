resource "aws_security_group" "kiykomi-sg" {
  name        = "My Dynamic Security Group"
  description = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = ["8080", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["193.109.128.157/32"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Dynamic Security Group"
    Owner   = "Mikhail Kiyko"
    Project = "PetClinic from kiykomi"
  }
}
