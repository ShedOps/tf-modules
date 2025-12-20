variable "additional_policy_arns_for_lambda_role" {
  type    = list(any)
  default = []
}

variable "environment" {
  type        = string
  description = "Environment name, usually set in etc"
}

variable "function_name" {
  type        = string
  description = "Name of the Lambda function whose resource policy you are updating."
}

variable "handler" {
  type        = string
  description = "Lambda function handler name"
}

variable "project_name" {
  type        = string
  description = "Project name, usually set in etc"
  default     = "Sandbox"
}

variable "runtime" {
  type        = string
  description = "The runtime environment for the Lambda function - e.g. python3.8."
}

variable "tags" {
  type        = map(any)
  description = "A map that defines tags for the Lambda function."
  default     = {}
}

variable "timeout" {
  type        = number
  description = "The amount of time your Lambda Function has to run, in seconds."
}

variable "os_env_vars" {
  type        = map(any)
  description = "A map that defines environment variables for the Lambda function."
}

variable "zip_path" {
  type        = string
  description = "The path to the function's deployment package within the local filesystem."
}

variable "memory_size" {
  type        = number
  default     = 128
  description = "Amount of memory in MB your Lambda Function can use at runtime."
}

variable "tracing_config" {
  type        = string
  default     = "PassThrough"
  description = "Tracing type, set to Active to enable XRay"
}

variable "log_group_retention_in_days" {
  type        = string
  default     = 0
  description = "Specifies the number of days you want to retain log events in the specified log group"
}
