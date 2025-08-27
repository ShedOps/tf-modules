variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS hostnames"
  type        = bool
  default     = true
}

variable "enable_flow_logs" {
  description = "Enable VPC flow logs"
  type        = bool
  default     = true
}

variable "env" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "name" {
  description = "Resource name"
  type        = string
  default     = "NOT_SET"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
  description = "Default CIDR block for VPC"
  type        = string
}
