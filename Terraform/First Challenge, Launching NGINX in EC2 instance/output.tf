output "instance_public_ip" {
  description = "EC2 instance public ID"
  value       = aws_instance.my-instance.public_ip
}
