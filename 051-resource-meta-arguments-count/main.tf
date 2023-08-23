terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


resource "aws_instance" "my_server" {
  count         = 2
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  tags = {
    Name = "Server-${count.index}"
  }

}


output "public_ip0" {
  value = aws_instance.my_server[0].public_ip
}

output "public_ip1" {
  value = aws_instance.my_server[1].public_ip
}

output "public_ipboth" {
  value = aws_instance.my_server[*].public_ip
}