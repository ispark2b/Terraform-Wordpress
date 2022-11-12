data "template_file" "ec2" {
  template = "${file("${path.module}/instance_user_data.tpl")}"
  vars = {
    wordpress_version = local.wordpress_version
  }
}