terraform {
  /*	
  cloud {
    organization = "ExamPro-TerraformLab"

    workspaces {
      name = "provisioners"
    }
  }
*/
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.12.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"

}

provider "null" {
  # Configuration options
}

data "aws_vpc" "my-vpc" {
  id = "vpc-033cc4428d7b9fa76"
}


resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "MyServer security group"
  vpc_id      = data.aws_vpc.my-vpc.id

  ingress = [
    {
      description      = "HTTP from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },

    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["72.224.13.47/32"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "All egress traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}


resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa "
}

data "template_file" "user_data" {
  template = file("./userdata.yaml")
}

resource "aws_instance" "my_server" {
  ami                         = "ami-09538990a0c4fe9be"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-06bf3cdb609f77eee"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.sg_my_server.id]
  user_data                   = data.template_file.user_data.rendered
  provisioner "file" {
    content     = "mars"
    destination = "/home/ec2-user/barsoon.txt"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("C:/Users/Johnathan Bangura Jr/.ssh/terraform")
      host        = self.public_ip
    }

  }

  tags = {
    Name = "MyServer"
  }
}

resource "null_resource" "status" {
  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.my_server.id}"
  }
  depends_on = [
    aws_instance.my_server
  ]
}

output "public_ip" {
  value = aws_instance.my_server.public_ip
}