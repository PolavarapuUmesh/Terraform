#aws_resource
provider "aws"{
 region="us-east-1"
}

# vpc
resource "aws_vpc" "jenkins_vpc"{
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags={
    Name = "jenkins_vpc"
  }
}

# 5 subnets 
resource "aws_subnet" "public_subnet_1"{
  vpc_id = aws_vpc.jenkins_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags={
    Name = "public_subnet1"
  }
}
resource "aws_subnet" "public_subnet_2"{
  vpc_id = aws_vpc.jenkins_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags={
    Name = "public_subnet2"
  }
}
resource "aws_subnet" "public_subnet_3"{
  vpc_id = aws_vpc.jenkins_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1c"
  tags={
    Name="public_subnet3"
  }
}
resource "aws_subnet" "private_subnet_1"{
  vpc_id = aws_vpc.jenkins_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1d"
  tags={
    Name="private_subnet1"
  }
}
resource "aws_subnet" "private_subnet_2"{
  vpc_id = aws_vpc.jenkins_vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1e"
  tags={
    Name="private_subnet2"
  }
}

#internet gateway 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.jenkins_vpc.id

  tags = {
    Name = "vpc_igw"
  }
}

#security_group 
resource "aws_default_security_group" "jenkins_sg" {
  vpc_id = aws_vpc.jenkins_vpc.id
 
  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#launch a ec2_machine
resource "aws_instance" "jenkins_instance"{
  ami = "ami_id"
  instance_type = "t3.micro"
  key_name="server"

  tags={
    Name="jenkins_server"
  }
}


