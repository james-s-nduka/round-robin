output "web_server_address" {
	value = "${aws_instance.web_server.public_dns}"
}
