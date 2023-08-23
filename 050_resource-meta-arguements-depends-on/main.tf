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

resource "aws_s3_bucket" "bucket" {
  bucket = "unique-bucket-name-12345"
  depends_on = [aws_instance.my_server]
}

resource "aws_instance" "my_server" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"

}

output "public_ip" {
  value = aws_instance.my_server.public_ip
}