terraform {

}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

module "apache" {
  source          = ".//terraform-aws-apache-example"
  subnet_id       = "subnet-02713b6cb764c6d00"
  vpc_id          = "vpc-033cc4428d7b9fa76"
  my_ip_with_cidr = "72.224.13.47/32"
  public_key      = "var.public_key"
  instance_type   = "t2.micro"
  server_name     = "Apache Example Server"
}

output "public_ip" {
  value = module.apache.public_ip
}

