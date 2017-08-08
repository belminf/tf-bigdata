resource "aws_instance" "linux" {

  instance_type = "${var.linux_instance_type}"
  ami = "${lookup(var.linux_amis, var.region)}"

  key_name = "${var.key_name}"

  root_block_device {
    volume_size = "${var.linux_root_gb}"
    volume_type = "${var.linux_root_type}"
  }

  vpc_security_group_ids = ["${aws_security_group.linux.id}"]
  subnet_id = "${aws_subnet.default.id}"

  tags = {
    Name = "bigdata_linux"
    Project = "bigdata_studying"
  }

  user_data = <<EOF
#!/usr/bin/env bash

# Create user
adduser ${var.linux_user}

# Get SSH authkeys from Github
mkdir ~${var.linux_user}/.ssh
chmod 700 ~${var.linux_user}/.ssh
curl https://github.com/${var.github_user}.keys >> ~${var.linux_user}/.ssh/authorized_keys
chmod 600 ~${var.linux_user}/.ssh/authorized_keys
chown -R ${var.linux_user}: ~${var.linux_user}/.ssh

# Setup sudo
echo "${var.linux_user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${var.linux_user}
chmod 440 /etc/sudoers.d/${var.linux_user}

EOF
}

output "ssh" {
  value = "${var.linux_user}@${aws_instance.linux.public_ip}"
}

resource "aws_instance" "win" {

  instance_type = "${var.win_instance_type}"
  ami = "${lookup(var.win_amis, var.region)}"

  key_name = "${var.key_name}"

  root_block_device {
    volume_size = "${var.win_root_gb}"
    volume_type = "${var.win_root_type}"
  }

  vpc_security_group_ids = ["${aws_security_group.win.id}"]
  subnet_id = "${aws_subnet.default.id}"

  tags = {
    Name = "bigdata_win"
    Project = "bigdata_studying"
  }

  user_data = <<EOF
<powershell>
([adsi]"WinNT://$$env:computername/Administrator").SetPassword(${var.win_password})
</powershell>
EOF
}

output "rdp" {
  value = "administrator@${aws_instance.win.public_ip}"
}
