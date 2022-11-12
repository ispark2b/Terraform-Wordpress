resource "aws_placement_group" "instances" {
  name     = "${local.resource_prefix}-instances"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "main-asg" {
  availability_zones = local.azs
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.wordpress-instance.id
    version = "$Latest"
  }
  depends_on = [
    module.db,
    module.main
  ]
}