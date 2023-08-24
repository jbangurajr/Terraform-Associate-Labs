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


data "aws_vpc" "main" {
  id = "vpc-033cc4428d7b9fa76"
}

locals {
  ingress = [{
    port        = 443
    description = "Port 443"
    protocol    = "tcp"
    },
    {
      port        = 80
      description = "Port 80"
      protocol    = "tcp"
    },
    {
      port        = 22
      description = "Port 22"
      protocol    = "tcp"
    },
    {
      port        = 3389
      description = "Port 3389"
      protocol    = "tcp"
  },{
    port        = 4789
    description = "Port 4789"
    protocol    = "udp"
  }]
}

resource "aws_security_group" "allow_tls" {
  name        = "Exam_pro_allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.main.id

  dynamic "ingress" {
    for_each = local.ingress
    content {
      description      = ingress.value.description
      from_port        = ingress.value.port
      to_port          = ingress.value.port
      protocol         = ingress.value.protocol
      cidr_blocks      = [data.aws_vpc.main.cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  }

  egress = [
    {
      description      = "outgoing for everyone"
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