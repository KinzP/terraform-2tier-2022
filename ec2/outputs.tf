#/EC2/outputs.tf 

output "aws_instance" {
  value = aws_instance.KP21_bastion[*].public_ip
}

output "ec2_tags" {
  value = aws_instance.KP21_bastion[*].tags_all.Name
}