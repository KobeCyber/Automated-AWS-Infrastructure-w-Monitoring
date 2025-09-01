# 1) Clone and enter
git clone <your-repo-url> aws-monitoring-terraform
cd aws-monitoring-terraform


# 2) (Optional) Copy example tfvars and edit your values
cp terraform.tfvars.example terraform.tfvars


# 3) Init + plan + apply
terraform init
terraform plan
terraform apply -auto-approve


# 4) After a few minutes, open Grafana (port 3000) or Prometheus (9090)
# Use the output public_url, or connect via SSM Session Manager.


# 5) Tear down when finished
terraform destroy -auto-approve
