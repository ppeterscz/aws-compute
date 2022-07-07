data "aws_ami" "ubuntu" {
  most_recent = "true"
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/*20.04-amd64-server-*"]
  }
  filter {
    name = "virtualisation-type"
    type = ["hvm"]
  }
  owners = [ "099720109477" ]
}

provider "aws" {
 region = "eu-central-1" 
}

resource "aws_instance" "enseq_server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "AWS_SSH_KEY"
  tags = {
    Name = var.ec2_name
  }
}

