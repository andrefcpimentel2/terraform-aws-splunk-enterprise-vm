
locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Name            = var.namespace
    owner           = var.owner
    created-by      = var.created-by
    se-region      = var.region
    terraform      = true
    purpose        = "Splunk Server"
  }
}


variable "region" {
  description = "The region to create resources."
  default     = "eu-west-2"
}

variable "namespace" {
  description = <<EOH
this is the differantiates different demostack deployment on the same subscription, everycluster should have a different value
EOH
  default     = "demostack"
}




variable "owner" {
  description = "Email address of the user responsible for lifecycle of cloud resources used for training."
}

variable "hashi_region" {
  description = "the region the owner belongs in.  e.g. NA-WEST-ENT, EU-CENTRAL"
  default = "EMEA"
}

variable "created-by" {
  description = "Tag used to identify resources created programmatically by Terraform"
  default     = "Terraform"
}


variable "vpc_cidr_block" {
  description = "The top-level CIDR block for the VPC."
  default     = "10.1.0.0/16"
}

variable "cidr_blocks" {
  description = "The CIDR blocks to create the workstations in."
  default     = "10.1.1.0/24"
}


variable "public_key" {
  description = "The contents of the SSH public key to use for connecting to the cluster."
}


variable "instance_type_server" {
  description = "The type(size) of data servers (consul, nomad, etc)."
  default     = "m4.large"
}


variable "host_access_ip" {
  description = "CIDR blocks allowed to connect via SSH on port 22"
  default     = []
}

