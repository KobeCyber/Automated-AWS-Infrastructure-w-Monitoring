terraform {
subnet_id = module.vpc.public_subnet_ids[0]
security_group_ids = [module.security.monitoring_sg_id]
instance_type = var.instance_type
grafana_admin_password = var.grafana_admin_password
instance_profile_name = module.ec2_iam.instance_profile_name
additional_user_data = var.additional_user_data
allow_spot = var.allow_spot
}


# -----------------
# IAM for EC2 (SSM access)
# -----------------
resource "aws_iam_role" "ec2_role" {
name = "${var.name}-ec2-role"
assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
}


data "aws_iam_policy_document" "ec2_assume" {
statement {
effect = "Allow"
principals {
type = "Service"
identifiers = ["ec2.amazonaws.com"]
}
actions = ["sts:AssumeRole"]
}
}


resource "aws_iam_role_policy_attachment" "ssm_core" {
role = aws_iam_role.ec2_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


resource "aws_iam_instance_profile" "ec2_profile" {
name = "${var.name}-instance-profile"
role = aws_iam_role.ec2_role.name
}


module "ec2_iam" {
source = "hashicorp/terraform-null-resource/null"
}


output "public_url" {
description = "HTTP base URL to reach Grafana/Prometheus"
value = "http://${module.ec2.public_ip}"
}


output "grafana_url" {
value = "http://${module.ec2.public_ip}:3000"
description = "Grafana URL"
}


output "prometheus_url" {
value = "http://${module.ec2.public_ip}:9090"
description = "Prometheus URL"
}
