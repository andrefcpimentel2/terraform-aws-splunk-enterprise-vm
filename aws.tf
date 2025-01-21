provider "aws" {
   region  = var.region
  #  alias   = "primary"
   # default_tags {
   #   tags = local.common_tags
  #  }
}

# Get Availability zones in the Region
data "aws_availability_zones" "AZ" {}

resource "aws_key_pair" "demostack" {
  key_name   = var.namespace
  public_key = var.public_key

  tags = local.common_tags
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags =  local.common_tags
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.cidr_blocks
  availability_zone       = data.aws_availability_zones.AZ.names[0]
  map_public_ip_on_launch = true


  tags =  local.common_tags
}

resource "aws_network_interface" "network_interface" {
  subnet_id       = aws_subnet.my_subnet.id
  security_groups = [aws_security_group.splunk_sg.id]
  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_main_route_table_association" "association" {
  vpc_id         = aws_vpc.my_vpc.id
  route_table_id = aws_route_table.public.id
}


resource "aws_security_group" "splunk_sg" {
  name_prefix = var.namespace
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.host_access_ip
  }

  ingress {
    description = "API Access"
    from_port   = 8088
    to_port     = 8089
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "UI Access"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Splunk Universal Forwarder"
    from_port   = 9997
    to_port     = 9997
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}