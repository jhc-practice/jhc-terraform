variable "coun" {
    default=2
}

variable "ami" {
}

variable "public_ip" {
    default=true
}

variable "instance_type" {
    default="t2.micro"
}
variable "vpc_id" {
    
}

variable "subnet_ids" {
}

variable "key_name" {
}


variable "web_ingress_rules" {
    type=map(object({
        port=number
        protocol=string
        cidr_blocks=list(string)
        description=string
    }))
}

variable "service" {
  default="ec2.amazonaws.com"
}
variable "role_name"{
    default="ec2-instance-role"
}
variable "policy_name"{
    default="ec2-instance-policy"
}
variable "versi"{
    default="2012-10-17"
}
variable "resource" {
    default="arn:aws:s3:::my-unique-bucket-015/*"
  
}