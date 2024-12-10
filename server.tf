data "aws_ami" "splunk" {
  most_recent = true
  owners      = ["679593333241"] ## Splunk Account 

  filter {
    name   = "name"
    values = ["splunk_AMI*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "splunk_ent" {
  ami           = data.aws_ami.splunk.id
  instance_type = var.instance_type_server
  key_name      = aws_key_pair.demostack.id

  tags =  local.common_tags

  network_interface {
    network_interface_id = aws_network_interface.network_interface.id
    device_index         = 0
  }
  availability_zone = data.aws_availability_zones.AZ.names[0]
}