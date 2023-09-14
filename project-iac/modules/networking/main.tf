resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags             = var.vpc_tags
}
#creating internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}
#creating route table for public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}
#subnets
resource "aws_subnet" "public" {
  count                   = var.subnet_count
  vpc_id                  = aws_vpc.main.id
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true
  cidr_block              = var.pub_cidrs[count.index]
}
#associate public subnets with public route table 
resource "aws_route_table_association" "public" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.public.id
}

#creating route table for private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  

}
#creating subnet
resource "aws_subnet" "private" {
  count             = var.subnet_count
  availability_zone = local.az_names[count.index]
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.pri_cidrs[count.index]
}
resource "aws_route_table_association" "private" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = aws_route_table.private.id
}


resource "aws_instance" "nat_instance" {
  ami                         =var.ami_id
  instance_type               = var.inst_type
  subnet_id                   = aws_subnet.public.*.id[0]
  associate_public_ip_address = true
  tags = {
    Name = "NAT_Instance"
  }
}
resource "aws_route" "route"{
  route_table_id=aws_route_table.private.id
  destination_cidr_block="0.0.0.0/0"
  #instance_id=aws_instance.nat_instance.id
  network_interface_id=aws_instance.nat_instance.primary_network_interface_id


}