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
