resource "aws_lambda_function" "yopass" {
  filename = "${path.module}/lambda_src/bin/yopass.zip"
  function_name = "yopass-${var.environment}"
  role = "${aws_iam_role.iam_for_lambda.arn}"
  handler = "yopass"
  source_code_hash = "${base64sha256(file("${path.module}/lambda_src/bin/yopass.zip"))}"
  runtime = "go1.x"
  memory_size = 128

  environment {
    variables {
      TABLE_NAME = "${var.dynamodb_table_name}"
    }
  }
}
