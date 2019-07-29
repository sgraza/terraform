provider "aws" {
  region     = "ap-southeast-1"
  profile    = "default"
}

resource "aws_vpc" "vpc_devops" {
  cidr_block = "${var.vpc_cidr_block}"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "igw"{
  vpc_id = "${aws_vpc.vpc_devops.id}"
}

resource "aws_subnet" "sub_public_devops" {
  vpc_id                  = "${aws_vpc.vpc_devops.id}"
  cidr_block              = "${var.subnet_cidr_block}"
  map_public_ip_on_launch = true
}

resource "aws_route_table" "rtb_public" {
  vpc_id = "${aws_vpc.vpc_devops.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = "${aws_subnet.sub_public_devops.id}"
  route_table_id = "${aws_route_table.rtb_public.id}"
}

resource "aws_security_group" "sg_devops" {
  name        = "sg_devops"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = "${aws_vpc.vpc_devops.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "kp_devops" {
  key_name   = "kp_devops"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "ec2_devops" {
  ami                         = "${var.instance_ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${aws_key_pair.kp_devops.id}"
  vpc_security_group_ids      = ["${aws_security_group.sg_devops.id}"]
  subnet_id                   = "${aws_subnet.sub_public_devops.id}"
  associate_public_ip_address = true
}