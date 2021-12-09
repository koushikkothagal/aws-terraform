terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_security_group" "sg" {
  name = "terraform-example-instance"

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami                    = "ami-830c94e3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data              = <<-EOF
                            #!/bin/bash
                            echo "Hello, World" > index.html
                            nohup busybox httpd -f -p ${var.app_port} &
                            EOF
  tags = {
    Name = var.app_tag_name
  }
}

output "public_ip" {
  value       = aws_instance.app_server.public_ip
  description = "The public IP address of the web server"
}

# resource "aws_vpc" "app_vpc" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = var.app_tag_name
#   }
# }


