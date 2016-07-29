output "web_server_address" {
	value = "${aws_instance.web_server.public_dns}"
}

output "app_private_ip_0" {
	value = "${module.app_servers.private_ip_0}"
}

output "app_private_ip_1" {
	value = "${module.app_servers.private_ip_1}"
}