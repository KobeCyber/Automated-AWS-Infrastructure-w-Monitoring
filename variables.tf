variable "name" { type = string default = "aws-monitoring" }
variable "region" { type = string default = "us-east-1" }


variable "vpc_cidr" { type = string default = "10.10.0.0/16" }
variable "public_subnet_cidrs" {
type = list(string)
default = ["10.10.1.0/24"]
}


variable "allow_cidr" {
description = "CIDR allowed to access HTTP/Prometheus/Grafana (and SSH if enabled)"
type = string
default = "0.0.0.0/0" # ⚠️ change to your IP/CIDR
}


variable "enable_ssh" { type = bool default = true }
variable "instance_type" { type = string default = "t3.micro" }


variable "grafana_admin_password" {
description = "Initial Grafana admin password"
type = string
sensitive = true
}


variable "additional_user_data" {
description = "Optional extra user_data script content appended to setup script"
type = string
default = ""
}


variable "allow_spot" {
description = "Use spot instances to save cost"
type = bool
default = false
}
