resource "aws_instance" "main" {
    count=var.coun
    ami=var.ami
    associate_public_ip_address=var.public_ip
    instance_type=var.instance_type
    subnet_id=var.subnet_ids[count.index]
    vpc_security_group_ids=[aws_security_group.web.id]
    key_name=var.key_name
    user_data=file("./scripts/httpd.sh")
    user_data_replace_on_change=true
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
    tags={
        Name="ec2-demo-${count.index}"
    }
  
}
#create security group for ec2
resource "aws_security_group" "web"{
    name="allow traffic for web"
    description="allow inbound traffic"
    vpc_id=var.vpc_id
    dynamic "ingress" {
        for_each=var.web_ingress_rules
        content{
            description="some description"
            from_port=ingress.value.port
            to_port=ingress.value.port
            protocol=ingress.value.protocol
            cidr_blocks=ingress.value.cidr_blocks
        }
    }
    egress{
        from_port=0
        to_port=0
        protocol="-1"
        cidr_blocks=["0.0.0.0/0"]
        ipv6_cidr_blocks=["::/0"]
    }
    tags={
        Name="ec2_security_rules"
    }
}

#creating iam role
resource "aws_iam_role" "ec2_instance_role"{
    name=var.role_name
    assume_role_policy=jsonencode({
        Version=var.versi,
        Statement=[{
            Action="sts:AssumeRole",
            Effect="Allow",
            Principal={
                Service=var.service
            }
        }]
    })
}

#creating iam policy
resource "aws_iam_policy" "ec2_instance_policy"{
    name=var.policy_name
    description="policy for ec2 instances"
    policy=jsonencode({
        Version=var.versi,
        Statement=[
            {
                Action=["s3:GetObject","s3:PutObject"],
                Effect="Allow",
                Resource=var.resource
            }
        ]
    })
}

resource "aws_iam_policy_attachment" "ec2_instance_role_attachment"{
    name="ec2_instance_role_attachment"
    policy_arn=aws_iam_policy.ec2_instance_policy.arn
    roles=[aws_iam_role.ec2_instance_role.name]
}

#aws instance profile
 resource "aws_iam_instance_profile" "ec2_profile"{
     name="ec2-profile"
     role=aws_iam_role.ec2_instance_role.name
 }
