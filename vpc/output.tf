 #/vpc/outputs.tf

output "vpc_id" {
  value = aws_vpc.KP21_vpc.id
}

output "public_subnets" {
  value = aws_subnet.public_subnet.*.id
}
output "private_subnet" {
  value = aws_subnet.private_subnet.*.id
}

output "public_sg" {
  value = aws_security_group.public_sg.id
} 