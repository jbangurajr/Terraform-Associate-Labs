module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


resource "aws_instance" "my_server" {
  ami                         = "ami-09538990a0c4fe9be"
  instance_type               = var.instance_type
  subnet_id                   = "subnet-091114eb750979a1e"
  associate_public_ip_address = true

  tags = {
    Name = "MyServer-${local.project_name}"
  }
}