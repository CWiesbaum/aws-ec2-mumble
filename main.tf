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

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "cloud-init.yaml"
    content_type = "text/cloud-config"
    content      = templatefile(
        "./scripts/cloud-init.yaml",
        {
          ssh_public_key = file(var.ssh_public_key_location),
          murmur_su_password = var.murmur_su_password,
          murmur_config_gzipb64 = base64gzip(file(var.murmur_config_location))
        }
      )
  }
}

resource "aws_instance" "murmur-server" {
  ami           = "ami-05983e3aff3bf44ba"
  instance_type = "t2.micro"
  user_data_base64 = "${data.template_cloudinit_config.config.rendered}"

  tags = {
    Name = "MurmurServer"
  }
}