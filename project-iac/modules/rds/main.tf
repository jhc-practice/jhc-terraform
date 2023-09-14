resource "aws_db_subnet_group" "db"{
    name="sunet-groups"
    subnet_ids=var.sub_ids
    tags={
        Name="rds-subnet-group"
    }
}
#configure credentials in cli using below command
#aws secretsmanager create-secret --name jhcrdsdb --secret-string '{"username":"seharabanu","password":"Babitha1015"}'

#CREATE RDS INSTANCE
resource "aws_db_instance" "main"{
    allocated_storage=var.storage
    db_name=var.db_name
    engine=var.db_engine
    engine_version=var.db_engine_version
    instance_class =var.db_instance_class
    username             =local.username
    password =local.password
    parameter_group_name=var.parameter_group_name
    skip_final_snapshot=true
    db_subnet_group_name=aws_db_subnet_group.db.name
    vpc_security_group_ids=[aws_security_group.rds.id]

}

#security group
resource "aws_security_group" "rds" {
  name        = "allow traffic for RDS"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.rds_ingress_rules
    content {
      description     = "some description"
      from_port       = ingress.value.port
      to_port         = ingress.value.port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = ingress.value.security_groups
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "rds_security_rules"
  }
}