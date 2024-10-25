# Crear VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr_block_vpc
  tags = {
    Name = "MainVPC"
  }
}

# Crear Subnet dentro de la VPC
resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.cidr_block_subnet
  availability_zone = "us-east-1a"
  tags = {
    Name = "MainSubnet"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow HTTP traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
