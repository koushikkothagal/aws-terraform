terraform {  
    required_providers {    
        aws = {      
            source  = "hashicorp/aws"      
            version = "~> 3.27"    
        }  
    }
  required_version = ">= 0.14.9"
}

variable "app_tag_name" {
  description = Value of Name tag"
  type        = string  
  default     = "app"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  tags = {
    Name = var.app_tag_name
  }
}

resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.app_tag_name
  }
}

