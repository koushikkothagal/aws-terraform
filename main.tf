provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  tags = {
    Name = "app"
  }
}

resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
}

