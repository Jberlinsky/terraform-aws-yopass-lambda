output "api_gateway_base_url" {
  value = "${aws_api_gateway_deployment.yopass.invoke_url}"
}

output "frontend_dns_name" {
  value = "${aws_cloudfront_distribution.yopass.domain_name}"
}

output "frontend_dns_zone_id" {
  value = "${aws_cloudfront_distribution.yopass.hosted_zone_id}"
}
