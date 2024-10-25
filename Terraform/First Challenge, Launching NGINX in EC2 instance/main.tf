resource "aws_instance" "my-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id       = aws_subnet.main_subnet.id
  associate_public_ip_address = true
  
  # User data to install Nginx automatically in the EC2 instance
  user_data = file(var.user_data_file_name)  
  
  vpc_security_group_ids = [ aws_security_group.web_sg.id ]

  tags = {
    Name = "NGINXonEC2Instance"
  }

  # Explicit dependencies
  depends_on = [
    aws_subnet.main_subnet,
    aws_security_group.web_sg
  ]
}