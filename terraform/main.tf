terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.9.0"
    }
    local = {
      source = "hashicorp/local"
      version = "~> 2.2.2"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~> 3.3.0"
    }

  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  shared_credentials_files = ["~/.aws/credentials"]
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ubuntu" {
  key_name   = "work_key_ireland2"
  public_key =  tls_private_key.pk.public_key_openssh 
}

resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.ubuntu.key_name}.pem"
  content = tls_private_key.pk.private_key_pem
  file_permission = "0400"
}

resource "aws_instance" "pg_server" {
  count = 3
  ami = "ami-0a2616929f1e63d91"
  instance_type = "t2.small"
  key_name = "work_key_ireland2" 
  vpc_security_group_ids = [aws_security_group.main.id]
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  },
  {
     cidr_blocks      = [ "172.31.0.0/16", ]
     description      = ""
     from_port        = 5432
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 5432
  },
  {
     cidr_blocks      = [ "172.31.0.0/16", ]
     description      = ""
     from_port        = 9700
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 9700
  },
  {
     cidr_blocks      = [ "172.31.0.0/16", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  },
  ]
}

