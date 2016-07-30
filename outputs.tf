output "web_server_address" {
	value = "${aws_instance.web_server.public_dns}"
}

output "web_server_ip" {
	value = "${aws_instance.web_server.public_ip}"
}
