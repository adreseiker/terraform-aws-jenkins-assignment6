variable "aws_region" {
  description = "AWS region (e.g., us-east-1 or ca-central-1)"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "Existing EC2 Key Pair name"
  type        = string
  default     = "cctb-assignment2-key"
}

variable "allowed_cidrs" {
  description = "CIDRs allowed for SSH (22)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ami_id" {
  description = "Optional: fixed Amazon Linux 2023 AMI. If empty, latest AL2023 via SSM"
  type        = string
  default     = ""
}
