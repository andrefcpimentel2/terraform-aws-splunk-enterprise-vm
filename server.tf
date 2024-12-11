data "aws_ami" "ubuntu" {
  most_recent = true

# ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*
#ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*
  filter {
    name   = "name"
    # values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    #  values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
      values = ["ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "splunk_ent" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type_server
  key_name      = aws_key_pair.demostack.id

  tags =  local.common_tags

  network_interface {
    network_interface_id = aws_network_interface.network_interface.id
    device_index         = 0
  }
  availability_zone = data.aws_availability_zones.AZ.names[0]

  user_data = data.cloudinit_config.servers.rendered
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Gzip cloud-init config
data "cloudinit_config" "servers" {

  gzip          = true
  base64_encode = true

  #base
  part {
    content_type = "text/x-shellscript"
    content      = templatefile("splunk.sh",{
        password = random_password.password.result
    })
   }
}