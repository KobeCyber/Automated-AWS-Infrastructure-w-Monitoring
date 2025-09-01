resource "aws_vpc" "this" {
cidr_block = var.cidr_block
enable_dns_hostnames = true
enable_dns_support = true
tags = { Name = "${var.name}-vpc" }
}


resource "aws_internet_gateway" "igw" {
vpc_id = aws_vpc.this.id
tags = { Name = "${var.name}-igw" }
}


resource "aws_subnet" "public" {
for_each = toset(var.public_subnet_cidrs)
vpc_id = aws_vpc.this.id
cidr_block = each.value
map_public_ip_on_launch = true
tags = { Name = "${var.name}-public-${replace(each.value, "/", "-")}" }
}


resource "aws_route_table" "public" {
vpc_id = aws_vpc.this.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.igw.id
}
tags = { Name = "${var.name}-public-rt" }
}


resource "aws_route_table_association" "public" {
for_each = aws_subnet.public
subnet_id = each.value.id
route_table_id = aws_route_table.public.id
}
