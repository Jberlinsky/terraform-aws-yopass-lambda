resource "null_resource" "react_build" {
  depends_on = ["aws_s3_bucket.yopass-frontend", "aws_api_gateway_deployment.yopass"]

  provisioner "local-exec" {
    // HACK HACK HACK
    // Come on, Terraform. There has to be a better way.
    command = "cd ${path.module}/react_src && yarn install && PUBLIC_URL=https://${var.yopass_fqdn} REACT_APP_BACKEND_URL=${aws_api_gateway_deployment.yopass.invoke_url} yarn build && aws s3 sync build/ s3://${aws_s3_bucket.yopass-frontend.id}/"
  }
}
