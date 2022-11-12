resource "aws_lb" "wordpress_lb" {
  name               = "${local.resource_prefix}-wordpress-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id,module.main.default_vpc_default_security_group_id]
  subnets            = module.main.public_subnets

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.lb-logs.bucket
    prefix  = "lb-logs"
    enabled = true
  }

  tags = local.tags
}

resource "aws_security_group" "lb" {
  name        = "${local.resource_prefix}-allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = module.main.vpc_id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = local.tags
}
resource "aws_lb_target_group" "wordpress-tg" {
  name        = "${local.resource_prefix}-wordpress-tg"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = module.main.vpc_id
}
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.main-asg.id
  lb_target_group_arn    = aws_lb_target_group.wordpress-tg.arn
}

resource "aws_lb_listener" "worpdress" {
  load_balancer_arn = aws_lb.wordpress_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-tg.arn
  }
}
