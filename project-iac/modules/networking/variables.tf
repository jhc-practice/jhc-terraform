variable "vpc_cidr" {
  default = "10.20.0.0/16"
}
variable "vpc_tags" {
  default = {
    Name = "app-vpc"
  }
}
variable "subnet_count" {
  default = 3
}
variable "pub_cidrs" {
  default = ["10.20.0.0/24", "10.20.1.0/24", "10.20.2.0/24"]
}

variable "pri_cidrs" {
  default = ["10.20.3.0/24", "10.20.4.0/24", "10.20.5.0/24"]
}
variable "ami_id" {
  default="ami-083ef72694a2c1f4f"
}
variable "inst_type" {
  default="t2.micro"
}