output "arn" {
  value       = aws_lambda_function.generic.arn
  description = "Lambda function arn"
}

output "function_name" {
  value       = aws_lambda_function.generic.function_name
  description = "The name of the Lambda function"
}

output "role_arn" {
  value       = aws_iam_role.lambda_iam_role.arn
  description = "IAM role arn"
}

output "invoke_arn" {
  value       = aws_lambda_function.generic.invoke_arn
  description = "The Lambda function invoke arn"
}
