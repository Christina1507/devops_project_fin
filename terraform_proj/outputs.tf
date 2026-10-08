output "ec2_1_public_ip" {
  value = aws_instance.instance1.public_ip
}

output "ec2_2_public_ip" {
  value = aws_instance.instance2.public_ip
}