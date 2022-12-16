terraform{
required_providers{
aws = {
  source = "hashicorp/aws"
  version = "~>4.0"
}
}
}

provider "aws"{
 region = "ap-south-1"
 access_key = var.access_key
 secret_key = var.secret_key
}

resource "aws_instance" "s1"{
ami = "ami-07ffb2f4d65357b42"
instance_type =var.instance_type
key_name = "grafanakey"
tags = {
Name = var.instance_name
}

user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install nginx -y
  echo "*** Completed Installing apache2"
  EOF

}

locals{
ingress_rules=[{
port=22
},{
port = 443
},{port = 80}]
}

resource "aws_security_group" "sg"{
 dynamic "ingress"{
 for_each = local.ingress_rules
 content {
 from_port = ingress.value.port
 to_port = ingress.value.port
 protocol= "tcp"
 cidr_blocks = ["0.0.0.0/0"]
}
}
}
