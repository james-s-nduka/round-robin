variable "vpc" { default = "vpc-847be3e1" }

variable "ami" {
	description = "Packer Created Centos Image in EU-WEST-1 region"
	default = "ami-7c94dc0f" 
}

variable "servers" {
	default = "2"
	description = "The number of app servers to launch"
}

variable "private_ips" {
	default = {
		"0" = "10.5.7.251"
		"1" = "10.5.7.225"
	}
}

variable "web_security_group" {}
variable "instance_type" { default = "t2.micro"}
variable "app_instance" { default = "app_server"}
variable "subnet_cidr" { default = "10.5.7.0/24" }
variable "keyname" { default = "mega_syndicate_west"}
variable "keyfile" { default = "./keys/mega_syndicate_west.pem"}
variable "environment" {}
variable "ip_for_ssh" {}