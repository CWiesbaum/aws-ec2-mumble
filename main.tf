terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.3.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

data "template_file" "cloud_init_config" {
    template = file("./scripts/cloud-init.yaml")

    vars = {
      ssh_public_key = file(var.ssh_public_key)
      murmur_su_passwort = var.murmur_su_passwort
    }
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "cloud-init.yaml"
    content_type = "text/cloud-config"
    content      = "${data.template_file.cloud_init_config.rendered}"
  }
}

resource "aws_instance" "murmur-server" {
  ami           = "ami-0b2a401a8b3f4edd3"
  instance_type = "t2.micro"
  user_data_base64 = "${data.template_cloudinit_config.config.rendered}"

  tags = {
    Name = "MurmurServer"
  }
}