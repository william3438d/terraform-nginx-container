# web ec2
resource "aws_instance" "web_ec2" {
  ami                    = var.AMIS[var.AWS_REGION]
  instance_type          = var.T2_TYPE
  subnet_id              = aws_subnet.web.id
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name               = aws_key_pair.mykeypair.key_name
  user_data              = data.template_cloudinit_config.init-web.rendered
  tags = {
    Name = "web"
  }
}


# app ec2
resource "aws_instance" "app_ec2" {
  ami                    = var.AMIS[var.AWS_REGION]
  instance_type          = var.T2_TYPE
  subnet_id              = aws_subnet.app.id
  vpc_security_group_ids = [aws_security_group.app.id]
  key_name               = aws_key_pair.mykeypair.key_name
  user_data              = "${file("scripts/user_data_app_backend.sh")}"
  tags = {
    Name = "app"
  }
}


# backend ec2
resource "aws_instance" "backend_ec2" {
  ami                    = var.AMIS[var.AWS_REGION]
  instance_type          = var.T2_TYPE
  subnet_id              = aws_subnet.backend.id
  vpc_security_group_ids = [aws_security_group.backend.id]
  key_name               = aws_key_pair.mykeypair.key_name
  user_data              = "${file("scripts/user_data_app_backend.sh")}"
  tags = {
    Name = "backend"
  }
}

#Display IP information in Terraform console
output "web-ip" {
  value = aws_instance.web_ec2.public_ip
}

output "web-dns" {
  value = aws_instance.web_ec2.public_dns
}

output "app-ip" {
  value = aws_instance.app_ec2.private_ip
}

output "backend-ip" {
  value = aws_instance.backend_ec2.private_ip
}
