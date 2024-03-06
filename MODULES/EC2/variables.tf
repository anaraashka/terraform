# variable "ami_id" {
#   default = "ami-061ac2e015473fbe2"
# }
variable "environment" {
    default = ""
}

variable "instance_type" {
  default = "t2.micro"
}

variable "subnet_id" {
    default = ""
}
 
variable "vpc_security_group" {
    type = list
    default = null
}

variable "instance_profile" {
    default = null
}

variable "key_name" {
  default = "devops-class-key"
}

variable "your_key" {}