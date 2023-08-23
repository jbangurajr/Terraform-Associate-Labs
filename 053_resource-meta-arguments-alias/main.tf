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
  alias   = "east"
}

provider "aws" {
  profile = "default"
  region  = "us-west-1"
  alias   = "west"
}

data "aws_ami" "east-amazon-linux-2" {
  provider    = aws.east
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_ami" "west-amazon-linux-2" {
  provider    = aws.west
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_instance" "my_server_east" {
  provider      = aws.east
  ami           = data.aws_ami.east-amazon-linux-2.id
  instance_type = "t2.micro"
  tags = {
    Name = "Server-east"
  }
}

resource "aws_instance" "my_server_west" {
  provider      = aws.west
  ami           = data.aws_ami.west-amazon-linux-2.id
  instance_type = "t2.micro"
  tags = {
    Name = "Server-west"
  }
}


output "public_ip_east" {
  value = aws_instance.my_server_east.public_ip
}

output "public_ip_west" {
  value = aws_instance.my_server_west.public_ip
}