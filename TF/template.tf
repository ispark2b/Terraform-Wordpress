data "template_file" "ec2" {
  template = "${file("${path.module}/instance_user_data.tpl")}"
  vars = {
    wordpress_version = local.wordpress_version
    db_root_password = local.db_password
    db_username = local.db_username
    db_user_password = local.db_password
    db_name = local.db_name
    db_endpoint = module.db.db_instance_endpoint
  }
  depends_on = [
    module.db
  ]
}