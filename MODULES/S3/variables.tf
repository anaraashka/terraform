variable "region" {
  type    = string
  default = "us-east-1"
}

variable "versioning_enabled" {
  type    = bool
  default = false
}

variable "s3_acl" {
  default = "private"
}

variable "environment" {
    default = ""
}

variable "create_s3" {
  default = true
}