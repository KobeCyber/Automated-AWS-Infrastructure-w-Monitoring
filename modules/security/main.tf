resource "aws_security_group" "monitoring" {
name = "${var.name}-monitoring-sg"
description = "Access for Grafana/Prometheus (and optional SSH)"
vpc_id = var.vpc_id


# HTTP (Grafana/Prometheus via direct ports)
ingress {
from_port = 3000
to_port = 3000
protocol = "tcp"
cidr_blocks = [var.allow_cidr]
description = "Grafana"
}


ingress {
from_port = 9090
to_port = 9090
protocol = "tcp"
cidr_blocks = [var.allow_cidr]
description = "Prometheus"
}


dynamic "ingress" {
for_each = var.enable_ssh ? [1] : []
content {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = [var.allow_cidr]
description = "SSH (optional)"
}
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
description = "All outbound"
}


tags = { Name = "${var.name}-monitoring-sg" }
}
