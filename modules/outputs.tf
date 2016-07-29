output "server_address" {
	value = "${aws_instance.app_node.0.public_dns}"
}

output "security_group" {
	value = "${aws_security_group.app_sg.id}"
}

output "private_ip_0" {
	value = "${aws_instance.app_node.0.private_ip}"
}

output "private_ip_1" {
	value = "${aws_instance.app_node.1.private_ip}"
}