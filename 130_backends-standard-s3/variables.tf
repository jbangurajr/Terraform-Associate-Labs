variable "bucket" {
  type    = string
  default = "terraform-backend-4329408jb"
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}


variable "my_ip_with_cidr" {
  type = string
}

variable "public_key" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "server_name" {
  type = string
}
