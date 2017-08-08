variable "tf_s3_bucket" {
  type = "string"
  description = "Bucket to use for TF state"
}
variable "tf_s3_key" {
  type = "string"
  description = "S3 key to use for TF state"
}

variable "tf_s3_region" {
  type = "string"
  description = "Region for TF state bucket"
}

variable "key_name" {
  type = "string"
  description = "Key pair name"
}

variable "region" {
  type = "string"
  default     = "us-east-1"
  description = "AWS region"
}

variable "remote_cidr_list" {
    type = "list"
    description = "List of CIDRs to get remote access"
}

variable "linux_instance_type" {
  type = "string"
  description = "AWS instance type"
}

# Amazon Linux 2017.03.1
variable "linux_amis" {
  type = "map"
  default = {
    us-east-1 = "ami-a4c7edb2"
    us-east-2 = "ami-8a7859ef"
  }
  description = "Amazon Linux AMIs"
}

variable "linux_root_gb" {
  type = "string"
  description = "Root volume size (GB)"
}

variable "win_instance_type" {
  type = "string"
  description = "AWS instance type"
}

variable "win_amis" {
  type = "map"
  default = {
    us-east-1 = "ami-a4c7edb2"
    us-east-2 = "ami-8a7859ef"
  }
  description = "Windows AMIs"
}

variable "win_root_gb" {
  type = "string"
  description = "Root volume size (GB)"
}


