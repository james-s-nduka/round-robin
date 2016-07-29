# Application server node
resource "aws_instance" "app_node" {
	ami = "${var.ami}"
	instance_type = "${var.instance_type}"
	subnet_id = "${aws_subnet.app.id}"
	security_groups = ["${aws_security_group.app_sg.id}"]
	user_data = "${file(var.app_user_data)}"
	key_name = "${var.keyname}"
	count = "${var.servers}"
	private_ip = "${lookup(var.private_ips, count.index)}"

	tags {
		Name = "${var.app_instance}-${count.index}"
	}

	connection {
		user = "centos"
		key_file = "${var.keyfile}"
		agent = "false"
	}

	provisioner "file" {
		source = "./chef/"
		destination = "/tmp"
	}

	provisioner "remote-exec" {
		inline = [
		    "cd /tmp",
            "sudo chef-client -z -o round-robin::appserver"
		]
	}
}

# Subnet for App Nodes
resource "aws_subnet" "app" {
	vpc_id = "${var.vpc}"
	cidr_block = "${var.subnet_cidr}"
	map_public_ip_on_launch = true

	tags {
		Name = "APP_ROUND_ROBIN"
	}
}

# Security Group for App Nodes
resource "aws_security_group" "app_sg" {
	name = "APP_ROUND_ROBIN"
	description = "App instance traffic rules"
	vpc_id = "${var.vpc}"

	ingress {
		from_port = 8484
		to_port = 8484
		protocol = "tcp"
		security_groups = ["${var.web_security_group}"]
	}

	# MAKE SURE TO DELETE
	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags {
		Name = "APP_SG"
	}
}