variable "environment" {
    default = ""
}

variable "sg_vpc" {
    default = ""
}

variable "sg_name" {
  description = "this variable allows you do understand the code"
  default     = "Devops allow all security group"
}

variable "sg_description" {
  default = "allow all sg"
}

variable "sg_ingress_from_port" {
  type    = number
  default = 0
}

variable "sg_ingress_to_port" {
  type    = number
  default = 0
}

variable "sg_ingress_protocol" {
  default = "-1"
}
variable "sg_ingress_cidr_blocks" {
  description = "used for security group ingress permissions"
  type        = list(any)
  default     = ["0.0.0.0/0"]
}

variable "sg_egress_from_port" {
  default = 0
}

variable "sg_egress_to_port" {
  default = 0
}

variable "sg_egress_protocol" {
  default = "-1"
}

variable "sg_egress_cidr_blocks" {
  default = ["0.0.0.0/0"]
}

variable "sg_egress_ipv6_cidr_blocks" {
  default = ["::/0"]
}