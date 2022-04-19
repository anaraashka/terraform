# Tag for VPC and Subnet
variable "Tag" {
  type        = string
  description = "This tag is applied for VPC and SUBNETS"
  default     = "Study-SS"
}
variable "CIDR" {
  type = list
  description = "These cirds are for VPC and SUBNETS"
  default = ["10.10.0.0/16","10.10.1.0/24","10.10.2.0/24","10.10.3.0/24","10.10.4.0/24","10.10.5.0/24","10.10.6.0/24","10.10.7.0/24","10.10.8.0/24"]
}