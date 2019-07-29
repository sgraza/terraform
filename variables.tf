variable "vpc_cidr_block" {
    description = "CIDR block of the VPC"
}
variable "subnet_cidr_block" {
    description = "CIDR block of the subnet"
}
variable "instance_ami" {
    description = "AMI ID of the EC2 Instance"
}
variable "instance_type" {
    description = "Instance type of the EC2 Instance"
}
variable "public_key_path" {
    description = "Public Key Path"
}
variable "name_tag" {
    description = "Environment Tag"
}