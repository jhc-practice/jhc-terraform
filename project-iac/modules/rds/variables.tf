variable "sub_ids" {
}
variable "db_engine"{
  default="postgres"
}
variable "db_engine_version"{
  default="14"
}
variable "db_instance_class"{
  default="db.t4g.large"
}
variable "parameter_group_name"{
  default="default.postgres14"
}

variable "storage" {
  default = 20
}
variable "db_name" {
  default = "jhcrdsdb"
}
variable "db_secret_name" {
  description = "Name of the AWS Secrets Manager secret"
}

variable "vpc_id" {
}
variable "rds_ingress_rules" {
  type = map(object({
    port            = number
    protocol        = string
    cidr_blocks     = list(string)
    description     = string
    security_groups = list(string)
  }))
}
