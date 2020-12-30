provider "aws" {
  region = "us-east-2"
  profile = "terraform"
}

variable "ingressrules" {
  type = list(number)
  default = [22,8080]
}

resource "aws_instance" "jenkins" {
  ami = "ami-0a0ad6b70e61be944"
  instance_type = "t2.medium"
  key_name = "jenkins-key"
  security_groups = [ aws_security_group.tcp_traffic.name ]
  user_data = file("install.jenkins.sh")
  tags = {
    Name = "Jenkins Server"
  }
}

resource "aws_security_group" "tcp_traffic" {
  name = "Allow SSH HTTP"
  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "ip_address" {
  value = aws_instance.jenkins.public_dns
}