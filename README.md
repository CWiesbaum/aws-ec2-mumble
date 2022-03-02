# aws-ec2-mumble
Terraform scripts to host a Mumble server on AWS EC2.

## How it works
These Terraform scripts create an EC2 instance based on [Fedora 35 Cloud Base Image](https://aws.amazon.com/marketplace/pp/prodview-doqa62vonqvo6?sr=0-5&ref_=beagle&applicationId=AWSMPContessa). The instance is configured on first boot using [cloud-init](https://cloudinit.readthedocs.io/en/latest/).

Modifications
- Admin user created with provided SSH public key for login
- Timezone set to *Europe/Berlin*
- System updates
- Install murmur and dnf-automatic
- Configure murmur systemd service
- Enable automatic dnf updates

## Setup
Currently an AWS EC2 t2.micro instance using terraform defaults is created. To run the IaC scripts follow these steps:

1. Configure AWS CLI

```
aws configure
```

2. Run terraform script providing your SSH Public Key location (defaults to: ~/.ssh/id_rsa.pub) and Murmur SuperUser password

```
terraform apply -var "ssh_public_key=<PATH TO PUBLIC KEY>" -var "murmur_su_passwort=<SUPERUSERPW>"
```

# License
All contents of this repository are published under GNU GENERAL PUBLIC LICENSE Version 2.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.