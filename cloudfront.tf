resource "aws_cloudfront_distribution" "yopass" {
  origin {
    domain_name = "${aws_s3_bucket.yopass-frontend.bucket_domain_name}"
    origin_id = "S3"
  }

  enabled = true
  is_ipv6_enabled = true
  default_root_object = "index.html"

  aliases = [
    "${var.yopass_fqdn}",
    "www.${var.yopass_fqdn}"
  ]

  default_cache_behavior {
    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "S3"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${var.acm_certificate_arn}"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}
