data "aws_ami" "al2023" {
most_recent = true
owners = ["amazon"]
filter {
name = "name"
values = ["al2023-ami-*-x86_64"]
}
}


locals {
setup_script = templatefile("${path.module}/user_data.tpl", {
grafana_admin_password = var.grafana_admin_password
additional_user_data = var.additional_user_data
})
}


resource "aws_instance" "this" {
ami = data.aws_ami.al2023.id
instance_type = var.instance_type
subnet_id = var.subnet_id
vpc_security_group_ids = var.security_group_ids
iam_instance_profile = var.instance_profile_name
user_data = local.setup_script


# Optional: spot to save cost
instance_market_options = var.allow_spot ? [{
market_type = "spot"
spot_options = {
max_price = null
}
}][0] : null


tags = { Name = "${var.name}-monitoring" }
}


output "instance_id" { value = aws_instance.this.id }
output "public_ip" { value = aws_instance.this.public_ip }
