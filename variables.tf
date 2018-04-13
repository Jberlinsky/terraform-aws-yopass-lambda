variable "environment" {
  description = "The environment to deploy to (production, staging, test)"
  default = "production"
}

variable "yopass_fqdn" {
  description = "The FQDN on which to host Yopass"
}

variable "acm_certificate_arn" {
  description = "The ACM Certificate ARN to use for Cloudfront"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table to store secrets in"
  default = "yopass-production"
}

variable "dynamodb_read_capacity" {
  description = "DynamoDB Read Capacity Units to provision"
  default = 5
}

variable "dynamodb_write_capacity" {
  description = "DynamoDB Write Capacity Units to provision"
  default = 5
}
