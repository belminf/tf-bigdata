resource "aws_instance" "linux" {

  instance_type = "${var.linux_instance_type}"
  ami = "${lookup(var.linux_amis, var.region)}"

  key_name = "${var.key_name}"

  root_block_device {
    volume_size = "${var.linux_root_gb}"
  }

  vpc_security_group_ids = ["${aws_security_group.linux.id}"]
  subnet_id = "${aws_subnet.default.id}"

  user_data = <<EOF
#!/usr/bin/env bash
curl https://github.com/${var.github_user}.keys >> /home/ec2-user/ssh/authorized_keys
EOF
}

output "ip" {
  value = "${aws_instance.linux.public_ip}"
}
