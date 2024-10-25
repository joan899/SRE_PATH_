resource "aws_instance" "my-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id       = aws_subnet.main_subnet.id

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "MiPrimerInstancia"
  }

  # Dependencia explícita
  depends_on = [aws_subnet.main_subnet]
}