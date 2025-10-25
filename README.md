# Assignment 6 – Terraform AWS Jenkins (Minimal Setup)

## Prerequisites
- AWS CLI configured (profile: `personal`)
- Existing EC2 Key Pair in your target region (default: `cctb-assignment2-key`)
- Terraform >= 1.5
- Region default: `us-east-1` (adjust in `terraform.tfvars`)

## What this does
- Uses **default VPC** in the selected region
- Creates a Security Group allowing SSH (22) from `allowed_cidrs` and Jenkins UI (8080)
- Launches an **Amazon Linux 2023** EC2 (`t3.micro`) and installs Jenkins via `user_data`
- (Optional) Deploys an **ALB** on HTTP:80 that forwards to Jenkins 8080

## How to run
```bash
terraform init
terraform plan  -var "aws_region=us-east-1" -var "key_name=cctb-assignment2-key"
terraform apply -auto-approve -var "aws_region=us-east-1" -var "key_name=cctb-assignment2-key"
```

To restrict SSH to your current IP:
- Set `allowed_cidrs = ["<YOUR_IP>/32"]` in `terraform.tfvars`

## Outputs
- `jenkins_public_ip` – visit `http://<ip>:8080`
- If you kept `load_balancer.tf`, also: `alb_dns_name` – visit `http://<dns>`

## Jenkins
Initial admin password on the instance:
```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

## Notes
- **Do not** commit real `terraform.tfvars` or any `.pem` keys. See `.gitignore`.
- For production, lock down ports and consider S3 backend & IAM roles.
