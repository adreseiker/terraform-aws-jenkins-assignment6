# Fixed Terraform Files for Assignment 6

These files ensure ALL resources (SGs, ALB, TG, EC2) use *your custom VPC* (`aws_vpc.main`) and *your custom public subnets* (`aws_subnet.main_a`, `aws_subnet.main_b`).

Replace these in your project and run:

```
terraform init
terraform validate
terraform plan -var "aws_region=us-east-1" -var "key_name=<your-key>"
terraform apply
```

Verify:
- Jenkins UI: `http://<jenkins_public_ip>:8080`
- ALB DNS: `http://<alb_dns_name>` alternates between Prod1 and Prod2.
