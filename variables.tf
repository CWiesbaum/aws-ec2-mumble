variable "ssh_public_key" {
  description = "SSH Public Key file used for User"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "murmur_su_passwort" {
  description = "Murmur SuperUser passwort"
  type        = string
}