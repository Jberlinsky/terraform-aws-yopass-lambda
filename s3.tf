resource "aws_s3_bucket" "yopass-frontend" {
  bucket = "${var.yopass_fqdn}"
  acl = "public-read"
  force_destroy = true

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT","POST"]
    allowed_origins = ["*"]
    expose_headers = ["ETag"]
    max_age_seconds = 3000
  }

  policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "PublicReadForGetBucketObjects",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.yopass_fqdn}/*"
    }
  ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

resource "aws_s3_bucket" "yopass-redirect" {
  bucket = "www.${var.yopass_fqdn}"
  acl = "public-read"

  website {
    redirect_all_requests_to = "${var.yopass_fqdn}"
  }
}
