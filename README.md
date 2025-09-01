# AWS Monitoring Infrastructure with Terraform

This project provisions a basic AWS infrastructure using Terraform and deploys a monitoring stack (Prometheus + Grafana) on an EC2 instance.

## Features

- AWS VPC, Subnet, and Security Groups
- EC2 instance with automated installation scripts
- Prometheus and Grafana setup
- Infrastructure as Code with Terraform modules

## Structure

- `/modules`: Terraform modules (VPC, EC2, security)
- `/scripts`: Bash scripts to install Prometheus and Grafana

##  Getting Started

1. Clone the repo
2. Configure AWS credentials
3. Run:
   ```bash
   terraform init
   terraform apply
