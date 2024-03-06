resource "aws_dynamodb_table" "ziyotek_devops_dynamodb_lock" {
  name     = "terraform-lock"
  hash_key = var.dynamodb_hash_key
  read_capacity = var.dynamodb_read_capacity
  write_capacity = var.dynamodb_write_capacity

  attribute {
    name = "LockID"
    type = var.dynamodb_attribute_type
  }
} 
