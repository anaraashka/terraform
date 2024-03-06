
variable "vpc_cidr" {
  default = ""
}

variable "zone_1" {
  default = "us-east-1a"
}

variable "zone_2" {
  default = "us-east-1b"
}

variable "subnet_cidrs" {
  default = [
    "10.10.1.0/24", 
    "10.10.2.0/24"
  ]
}