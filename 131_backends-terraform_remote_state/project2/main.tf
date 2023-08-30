provider "aws" {
	profile = "default"
	region = "us-east-1"
}

data "terraform_remote_state" "vpc" {
	backend = "local"
	config = {
		path = "../project1/terraform.tfstate"
	}
}


module "apache" {
  source          = "jbangurajr/apache-example/aws"
  version         = "v1.0.5"
  vpc_id          = data.vpc.vpc_id
  subnet_id       = data.vpc.public_subnets[0]
  my_ip_with_cidr = var.my_ip_with_cidr
  public_key      = var.public_key
  instance_type   = var.instance_type
  server_name     = var.server_name
}

output "public_ip" {
  value = module.apache.public_ip
}