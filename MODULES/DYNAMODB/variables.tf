variable "dynamodb_hash_key" {
  default = "LockID"
}

variable "dynamodb_read_capacity" {
  default = "20"
}

variable "dynamodb_write_capacity" {
  default = "20"
}

variable "dynamodb_attribute_type" {
  default = "S"
}