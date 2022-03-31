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
  availability_zone = "eu-central-1a"
  user_data_base64 = "${data.template_cloudinit_config.config.rendered}"

  security_groups = [
      "${aws_security_group.murmur-server-sg.name}"
  ]

  root_block_device {
    delete_on_termination = false
    encrypted = false
    volume_size = 5
    volume_type = "gp2"
    tags = {
        Name = "MurmurServer"
    }      
  }

  tags = {
    Name = "MurmurServer"
  }
}