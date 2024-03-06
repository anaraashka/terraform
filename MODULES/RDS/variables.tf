variable "environment" {
  default = ""  
}

variable "subnet_ids" {
  default = ""
}

variable "db_storage" {
  default = "10"
}

variable "db_version" {
  default = "10.15"
}

variable "db_name" {
  default = "ziyotek"
}

variable "db_username" {
  default = "ziyotekuser"
}

variable "vpc_security_group" {
  default = ""
}