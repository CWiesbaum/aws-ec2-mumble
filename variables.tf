variable "ssh_public_key_location" {
  description = "SSH Public Key file location used for admin user"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "murmur_su_password" {
  description = "Murmur SuperUser password"
  type        = string
}

variable "murmur_config_location" {
  description = "Mumble Server config file location"
  type        = string
  default     = "./scripts/murmur-server.ini"
}