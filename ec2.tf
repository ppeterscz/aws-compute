## Random

resource "random_pet" "enseq_sg" {}

## Create AWS EC2 instance
resource "aws_vpc" "enseq_vpc" {
  cidr_block = "10.50.0.0/16"
  tags = {
    Name = "ensequre-vpc"
  }
}

## Create VPC Subnet
resource "aws_subnet" "enseq_vpc_sub" {
  vpc_id = aws_vpc.enseq_vpc.id
  cidr_block = "10.50.5.0/24"

  tags = {
    Name = "ensequre-vpc-subnet"
  }
}

## Create Network Interface
resource "aws_network_interface" "enseq_vpc_sub_int" {
  subnet_id = aws_subnet.enseq_vpc_sub.id
  private_ips = [ "10.50.5.100" ]
  tags = {
    Name = "ensequre-vpc-sub-interface"
  }
}

## AWS Security Group
resource "aws_security_group" "enseq_vpc_sg" {
  name = "${random_pet.sg.id}-sg"
  vpc_id = aws_vpc.enseq_vpc.id
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

## Create AWS EC2
resource "aws_instance" "enseq_ec2" {
  ami = "ami-07f16fb14274bfc76"
  instance_type = "t3.micro"

network_interface {
  network_interface_id = aws_network_interface.enseq_vpc_sub_int.id
  device_index=0
}
}
