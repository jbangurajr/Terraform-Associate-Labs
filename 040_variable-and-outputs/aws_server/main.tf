terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.58.0"
    }
  }
}



variable "instance_type" {
	type = string
  description = "The size of the instance."
  sensitive = false
	validation {
    condition     = can(regex("^t2.",var.instance_type))
    error_message = "The instance must be a t2 type EC2 instance."
	}
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


locals {
  instance_type = var.instance_type
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "my_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               =  local.instance_type
  subnet_id                   = "subnet-091114eb750979a1e"
  associate_public_ip_address = true

}

output "public_ip" {
  value = aws_instance.my_server.public_ip
  sensitive = false
}