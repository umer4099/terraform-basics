terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
##################################
#Ec2 instace block
##################################
resource "aws_instance" "example_server" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  subnet_id     = element(data.terraform_remote_state.vpc.outputs.public_subnet, 0)
  security_groups = [aws_security_group.web_server_sg_tf.id]
  user_data     = <<EOF
#!/bin/bash
echo "Copying the SSH Key to the server"
echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDz9kPlbhG3fZc5npyAAYwrtwUnhN4bXXl0GzSKQbwIDziL1luYAmLCX4fJEBGXcPq2MOPq0wOfdEi8mOCiKn64tDDKaUckMfztsXBC0cxtHMJ5OZ1QUzKhtDmDGYhprApaknFIsyCqVCnSgGC8BY4TJ2vzronQATUNbMSQdxZRgkJV84uxc2TOA0n1lmdaZQjXHTKvvpxbYtbrkmnjFHpDaaa5n0phYtNaWpeGPKaHGOR8UFQjEzjUqUs3Qt17Wg6qM8j5oQMdbwxIM4dpvF54JA2kAm1y/rzJ/rPWyjKH9meu9NKRIVixMJcZPzObcHi+fRtxobG+sMNBNBxTjpnfROILRtWvyxeEf61c0WeS/PHCuLNbgjiaQh2vFhEXWGJb4I4ex/+c1Hmf+P5riLL3JrsFuI3wXAHGxR2/WWZfjES/cu1xpcXVTuRMxqQ95lzjRBhd2FRLqgMCJ5tQvAI9mqDb2hTT7a9NH0IwMAxnnxPZBrwixif2J8jI3EYhF2M= umer@pop-os
" >> /home/ubuntu/.ssh/authorized_keys
EOF

  tags = {
    Name = "ubuntu-Example"
  }
}
##################################
#this block for ec2 secuirty group
##################################
resource "aws_security_group" "web_server_sg_tf" {
 name        = "web-server-sg-tf"
 description = "Allow HTTPS to web server"
 vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

ingress {
   description = "ssh ingress"
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}