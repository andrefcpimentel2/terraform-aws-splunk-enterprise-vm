data "aws_ami" "ubuntu" {
#  for_each = toset(["amd64", "arm64"])

  filter {
    name   = "name"
    values = [format("hc-base-ubuntu-2204-*", "amd64")]
    # values = [format("hc-base-ubuntu-2404-%s-*", each.value)]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
  most_recent = true
  owners      = ["888995627335"] # hc-ami_prod
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
  user_data                   = data.template_file.init.rendered
  
    root_block_device {
    volume_size           = "240"
    delete_on_termination = "true"
  }

  ebs_block_device {
    device_name           = "/dev/xvdd"
    volume_type           = "gp2"
    volume_size           = "240"
    delete_on_termination = "true"
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


data "template_file" "init" {
  template = "${file("splunk.sh")}"
  vars = {
    splunk_password = random_password.password.result
    namespace = var.namespace
  }
}
