#####################
# outputs.tf (FIXED)#
#####################

output "jenkins_public_ip" {
  description = "Public IP of JenkinsController"
  value       = aws_instance.JenkinsController.public_ip
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.alb.dns_name
}
