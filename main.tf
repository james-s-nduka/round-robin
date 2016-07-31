provider "aws" {
	region = "${var.aws_region}"
	access_key = "${var.access_key}"
	secret_key = "${var.secret_key}"
}

resource "aws_instance" "web_server" {
	ami = "${var.ami}"
	instance_type = "${var.instance_type}"
	subnet_id = "${aws_subnet.web.id}"
	security_groups = ["${aws_security_group.web_sg.id}"]
	key_name = "${var.keyname}"

	tags {
		Name = "${var.web_instance}"
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
            "sudo chef-client -z -o round-robin::webserver",
            "sudo setenforce permissive"
		]
	}
}


# Subnet for Web Node
resource "aws_subnet" "web" {
	vpc_id = "${var.vpc}"
	cidr_block = "${var.subnet_cidr}"
	map_public_ip_on_launch = true

	tags {
		Name = "WEB_ROUND_ROBIN"
	}
}

# Security Group for Web Node
resource "aws_security_group" "web_sg" {
	name = "WEB_ROUND_ROBIN"
	description = "Web instance traffic rules"
	vpc_id = "${var.vpc}"

	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	# Only allow inbound from Workstation, CI Server, Test and Prod
	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["${var.ip_for_ssh}/32"]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags {
		Name = "WEB_SG"
	}
}

module "app_servers" {
	source = "./modules"
	servers = 2
	web_security_group = "${aws_security_group.web_sg.id}"
	environment = "${var.environment}"
	ip_for_ssh = "${var.ip_for_ssh}"
}
