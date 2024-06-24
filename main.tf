provider "aws" {
  region = "eu-west-1"
}

variable "server_port" {
  type    = number
  default = 8080
}
output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "Public ip of web server "
}

resource "aws_instance" "example" {
  ami                         = "ami-0f29c8402f8cce65c"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.instance.id]
  user_data                   = <<-EOF
  #!bin/bash
  echo "jak sie masz chujku!!!" > index.html
  nohup busybox httpd -f -p ${var.server_port} &
  EOF
  user_data_replace_on_change = true
  tags = {
    Name = "example"
  }

}

resource "aws_security_group" "instance" {
  name = "terraform_example_instance "
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
