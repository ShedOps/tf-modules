locals {
  common_tags = {
    Environment = var.environment
    Name        = "${var.project_name}-${var.function_name}"
    Project     = var.project_name
    Technology  = "lambda"
    Managed_by  = "terraform"
  }
}

resource "aws_lambda_function" "generic" {
  filename         = var.zip_path
  function_name    = var.function_name
  handler          = var.handler
  role             = aws_iam_role.lambda_iam_role.arn
  runtime          = var.runtime
  source_code_hash = filebase64sha256(var.zip_path)
  timeout          = var.timeout
  memory_size      = var.memory_size

  tracing_config {
    mode = var.tracing_config
  }

  # OS.ENVIRON Environment Variables for external control of the Lambda function (if you need it)
  # type=map
  environment {
    variables = var.os_env_vars
  }

  # Advanced logging configuration
  logging_config {
    log_format            = "JSON"
    application_log_level = "INFO"
    system_log_level      = "WARN"
  }
  tags = merge(local.common_tags, var.tags)
}
