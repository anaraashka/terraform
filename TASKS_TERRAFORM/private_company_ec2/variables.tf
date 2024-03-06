variable "VPC-NAME" {
  type    = string
  default = "Shark"
}

variable "VPC-CIDR" {
  type    = string
  default = "10.80.0.0/16"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "ec2tag" {
  type    = list(any)
  default = ["APP", "DEV", "WEB"]
}

# variable "cidrs" {
#   type    = list(string)
#   default = ["10.70.0.0/16", "10.70.1.0/24", "10.70.2.0/24"]
# }

# variable "av_zones" {
#   type    = list(string)
#   default = ["us-east-1a", "us-east-1b"]
# }