resource "aws_cloudwatch_log_group" "generic" {
  name              = "/aws/lambda/${aws_lambda_function.generic.function_name}"
  tags              = merge(local.common_tags, var.tags)
  retention_in_days = var.log_group_retention_in_days
}
