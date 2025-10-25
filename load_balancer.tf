############################
# load_balancer.tf (FIXED) #
# - ALB in custom subnets
# - TG in custom VPC
# - Attach Prod1/Prod2
############################

# Application Load Balancer in our public subnets
resource "aws_lb" "alb" {
  name               = "alb-prod"
  load_balancer_type = "application"
  subnets            = [aws_subnet.main_a.id, aws_subnet.main_b.id]
  security_groups    = [aws_security_group.alb_sg.id]

  tags = { Name = "alb-prod" }
}

# Target Group for port 80 in our custom VPC
resource "aws_lb_target_group" "prod_tg" {
  name     = "tg-prod-80"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200-399"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 5
  }
}

# Listener on :80 forwarding to TG
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_tg.arn
  }
}

# Attach Production targets
resource "aws_lb_target_group_attachment" "prod1_attach" {
  target_group_arn = aws_lb_target_group.prod_tg.arn
  target_id        = aws_instance.Production_Env1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "prod2_attach" {
  target_group_arn = aws_lb_target_group.prod_tg.arn
  target_id        = aws_instance.Production_Env2.id
  port             = 80
}
