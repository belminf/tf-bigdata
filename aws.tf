provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    key    = "bigdata/terraform.tfstate"
  }
}
