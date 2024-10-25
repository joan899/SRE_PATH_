variable "aws_region" {
  description = "La región de AWS donde se creará la instancia EC2"
  default     = "us-east-1"  # Puedes cambiar esto a la región que prefieras.
}

variable "instance_type" {
  description = "El tipo de instancia EC2 que se va a crear"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID that will launch the instance"
  default     = "ami-0ebfd941bbafe70c6" 
}

variable "cidr_block_vpc" {
  description = "VPC cidr_block"
  default     = "10.0.0.0/16"
}

variable "cidr_block_subnet" {
  description = "Subnet cidr_block"
  default     = "10.0.0.0/24"
}

variable "user_data_file_name" {
  description = "User data file name that will create the Nginx web server"
  default     = "user_data.sh"
}

variable "subnet_availability_zone" {
  description = "availability zone where the subnet is going to be placed"
  default     = "us-east-1a"
}