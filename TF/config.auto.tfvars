tf_version = "v1.0.0"
stage = "dev"
project = "wordpress"
resource_prefix = "wp"

#EC2
wordpress_version = "latest"
instance_type = "t2.micro"

#RDS
db_name = "wordpress_db"
db_username = "wordpress"
db_password = "supersecretpassword123"
db_port = "3306"
db_instance_size = "db.t2.micro"