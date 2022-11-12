resource "aws_launch_template" "wordpress-instance" {
  name = "${local.resource_prefix}"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
      encrypted = true
      delete_on_termination = true
      volume_type = "gp3"
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }


  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_stop        = false
  disable_api_termination = false

  ebs_optimized = true

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2.name
  }

  image_id = data.aws_ami.amazon_linux.id

  instance_initiated_shutdown_behavior = "terminate"

  instance_market_options {
    market_type = "spot"
  }

  instance_type = local.instance_type

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
  }


  vpc_security_group_ids = [aws_security_group.allow_http.id]

  tag_specifications {
    resource_type = "instance"
    tags = local.tags
  }

  user_data = data.template_file.ec2.rendered
}
resource "aws_security_group" "allow_http" {
  name        = "${local.resource_prefix}-allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = module.main.vpc_id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [local.main_vpc_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = local.tags
}