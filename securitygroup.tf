resource "aws_security_group" "web" {
  vpc_id      = aws_vpc.main.id
  name        = "web sec"
  description = "Reachable via internet on port 22 and 443"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sec"
  }
}


resource "aws_security_group" "app" {
  vpc_id      = aws_vpc.main.id
  name        = "app sec"
  description = "Reachable only from Web VM on ports 80 and 22. Can reach backend on port 22 and port 80"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.web_ec2.private_ip}/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.web_ec2.private_ip}/32"]
  }

  tags = {
    Name = "app-sec"
  }
}


resource "aws_security_group" "backend" {
  vpc_id      = aws_vpc.main.id
  name        = "backend sec"
  description = "Reachable only from App VM  on ports 22 and 80"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.app_ec2.private_ip}/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.app_ec2.private_ip}/32"]
  }

  tags = {
    Name = "backend-sec"
  }
}
