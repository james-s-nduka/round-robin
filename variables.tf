variable "aws_region" { default = "eu-west-1" }
variable "vpc" { default = "vpc-847be3e1" }
#Latest Centos 7 Image
variable "ami" { default = "ami-cb8fe3b8" }
variable "instance_type" { default = "t2.micro"}
variable "web_instance" { default = "web_server"}
variable "subnet_cidr" { default = "10.5.6.0/24"}
variable "web_user_data" { default = "./scripts/web_server.sh"}
variable "keyname" { default = "mega_syndicate_west"}
variable "keyfile" { default = "./keys/mega_syndicate_west.pem"}

variable "access_key" {}
variable "secret_key" {}
variable "environment" {}
variable "ip_for_ssh" {}
