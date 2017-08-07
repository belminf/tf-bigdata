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
