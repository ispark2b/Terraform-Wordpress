resource "aws_iam_instance_profile" "ec2" {
  name = "${local.resource_prefix}-wordpress_instance"
  role = aws_iam_role.ec2.name
}

resource "aws_iam_role" "ec2" {
  name = "${local.resource_prefix}-wordpress_instance"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}