output "ip" {
  value = "${aws_instance.ec2_devops.public_ip}"
}