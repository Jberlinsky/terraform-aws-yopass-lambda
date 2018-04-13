resource "aws_iam_role" "iam_for_lambda" {
  name = "yopass-${var.environment}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "yopass-dynamodb" {
    name        = "yopass-${var.environment}-dynamodb"
    description = "Allow Yopass to interact with DynamoDB"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:DeleteItem",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "${aws_dynamodb_table.yopass.arn}"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "yopass-cloudwatch" {
    name        = "yopass-${var.environment}-cloudwatch"
    description = "Allow Yopass to interact with CloudWatch"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "yopass-dynamodb" {
  role = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = "${aws_iam_policy.yopass-dynamodb.arn}"
}

resource "aws_iam_role_policy_attachment" "yopass-cloudwatch" {
  role = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = "${aws_iam_policy.yopass-cloudwatch.arn}"
}
