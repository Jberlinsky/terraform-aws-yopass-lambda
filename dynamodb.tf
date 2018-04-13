resource "aws_dynamodb_table" "yopass" {
  name = "${var.dynamodb_table_name}"

  ttl {
    attribute_name = "ttl"
    enabled = true
  }

  attribute {
    name = "id"
    type = "S"
  }

  hash_key = "id"

  read_capacity = "${var.dynamodb_read_capacity}"
  write_capacity = "${var.dynamodb_write_capacity}"
}
