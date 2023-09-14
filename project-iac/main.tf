module "jhc_vpc" {
  source = "./modules/networking"
  vpc_tags = {
    Name = "jhc-app"
  }
}

module "webapp"{
    source="./modules/ec2"
    ami="ami-0cf0e376c672104d6"
    key_name="terra-demo"
    vpc_id=module.jhc_vpc.vpc_id
    subnet_ids=module.jhc_vpc.pub_sub_ids
    web_ingress_rules={
        "22"={
            port=22
            protocol="tcp"
            #generally we provide the ip address/security group of the server which connects to this 
            cidr_blocks=["0.0.0.0/0"]
            description="allow ssh"

         }
         "80"={
             port=80
             protocol="tcp"
            #generally we provide the ip address/security group of the server which connects to this 
            cidr_blocks=["0.0.0.0/0"]
            description="allow 80 everywhere"
        }
    }

}

module "myappalb" {
  source     = "./modules/loadbalancer"
  vpc_id     = module.jhc_vpc.vpc_id
  subnet_ids = module.jhc_vpc.pub_sub_ids
  alb_ingress_rules = {
    "80" = {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "allow 80 everywhere"
    }
  }
  instance_ids = module.webapp.instance_ids
}

# The following tags should be there are every resource created in terraform
# AppName="hr-automation"
# CostCenter="JHC777"


# Create RDS
module "jhc_rds" {
  source  = "./modules/rds"
  sub_ids = module.jhc_vpc.pri_sub_ids
  vpc_id  = module.jhc_vpc.vpc_id
  db_secret_name="jhcrdsdb"
  # username="arn:aws:secretsmanager:us-east-2:879960988225:secret:jhcrdsdb-zUDWeB-username-secret-arn"
  # password="arn:aws:secretsmanager:us-east-2:879960988225:secret:jhcrdsdb-zUDWeB-password-secret-arn"
  rds_ingress_rules = {
    "app1" = {
      port            = 5432
      protocol        = "tcp"
      cidr_blocks     = []
      description     = "allow ssh within organization"
      security_groups = [module.webapp.security_group_id]
    }
  }
}

module "lambda_func"{
  source  = "./modules/lambda"
  #handler=hello.handler
  run_time="python3.11"
  file_name="C:/Users/babit/OneDrive/Desktop/lambdademo.zip"
}










































































































































































































































































































