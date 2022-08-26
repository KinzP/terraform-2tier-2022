#ec2/main.tf
data "aws_ami" "server_ami" {
    most_recent = true
    owners = ["amazon"]

    filter {
        name = "name"
        values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220426.0-x86_64-*"]
    }
}

resource "aws_key_pair" "KP21_kp" {
    key_name = var.key_name
    public_key = file(var.public_key_path)

}

resource "aws_instance" "KP21_private" {
    instance_type = var.instance_type 
    ami = data.aws_ami.server_ami.id
    tags = {
        Name = "KP21_private"
    }
}

resource "aws_instance" "KP21_bastion" { 
    instance_type = var.instance_type 
    ami = data.aws_ami.server_ami.id
    tags = {
        Name = "KP21_bastion"
    }
key_name = aws_key_pair.KP21_kp.id
vpc_security_group_ids = [var.public_sg]
subnet_id = var.public_subnets

root_block_device {
    volume_size = var.vol_size 
    }
}
resource "aws_lb_target_group_attachment" "KP21_tga" {
    count = var.instance_count
    target_group_arn = var.lb_target_group_arn
    target_id = aws_instance.KP21_bastion.id
    port = 8000
}