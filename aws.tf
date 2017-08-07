provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "bigdata_vpc"
    Project = "bigdata_studying"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
  tags = {
    Name = "bigdata_igw"
    Project = "bigdata_studying"
  }
}

resource "aws_route" "public" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

resource "aws_subnet" "default" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "bigdata_sn_public"
    Project = "bigdata_studying"
  }
}

resource "aws_security_group" "linux" {
  name        = "bigdata_sg_liunx"
  vpc_id      = "${aws_vpc.default.id}"
  tags = {
    Project = "bigdata_studying"
  }

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.remote_cidr_list}"
  }

  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "win" {
  name        = "bigdata_sg_win"
  vpc_id      = "${aws_vpc.default.id}"
  tags = {
    Project = "bigdata_studying"
  }

  # SSH access from anywhere
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = "${var.remote_cidr_list}"
  }

  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


/*
resource "aws_instance" "linux" {

  instance_type = "${var.linux_instance_type}"

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.linux_amis, var.region)}"

  # The name of our SSH keypair we created above.
  key_name = "${var.key_name}"

  root_block_device {
    volume_size = "${var.linux_root_gb}"
  }

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${aws_subnet.default.id}"

  # We run a remote provisioner on the instance after creating it.
  # In this case, we just install nginx and start it. By default,
  # this should be on port 80
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
      "sudo service nginx start",
    ]
  }
}
*/
