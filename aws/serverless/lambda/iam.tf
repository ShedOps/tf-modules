resource "aws_iam_role" "lambda_iam_role" {
  name = var.function_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
  tags               = merge(local.common_tags, var.tags)

}

resource "aws_iam_role_policy_attachment" "attach_policies" {
  count      = length(var.additional_policy_arns_for_lambda_role)
  role       = aws_iam_role.lambda_iam_role.id
  policy_arn = var.additional_policy_arns_for_lambda_role[count.index]
}
