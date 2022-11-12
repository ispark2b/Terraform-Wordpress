variable "tf_version" {
  description = "Terraform version"
  type = string
  default = "v1.0.0"
}

variable "stage" {
  description = "Stage"
  type = string
  default = "dev"
}

variable "project" {
  description = "Project"
  type = string
  default = "wordpress"
}

variable "resource_prefix" {
  description = "Prefix for the resources created"
  type = string
  default = "wp"
}

variable "wordpress_version" {
  description = "wordpress version"
  type = string
  default = "latest"
}

variable "instance_type" {
  description = "instance type"
  type = string
  default = "t2.micro"
}

#RDS
variable "db_name" {
  description = ""
  type = string
  default = "wordpress_db"
}
variable "db_username" {
  description = ""
  type = string
  default = "wordpress"
}
variable "db_password" {
  description = ""
  type = string
  default = "supersecretpassword123"
}
variable "db_port" {
  description = ""
  type = string
  default = "3306"
}
variable "db_instance_size" {
  description = ""
  type = string
  default = "db.t2.micro"
}

