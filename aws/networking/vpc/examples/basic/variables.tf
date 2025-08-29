variable "aws_region" {
  description = "Default AWS Region"
  default     = "eu-west-1"
  type        = string
}

variable "default_subnets" {
  description = "Mapping of AZ keys to public/private subnets"
  type = map(object({
    default_public_subnet_cidr  = string
    default_private_subnet_cidr = string
  }))
}

variable "enable_dns_hostnames" {
  description = "Enable or Disable DNS Hostnames"
  default     = true
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable or Disable DNS Support"
  default     = true
  type        = bool
}

variable "environment" {
  description = "Target Environment - sandbox is generic, but could be dev, staging, integration, production etc"
  default     = "sandbox"
  type        = string
}

variable "vpc_cidr_block" {
  description = "Default VPC CIDR Block"
  default     = "10.11.0.0/16"
  type        = string
}

variable "vpc_enable_flow_logs" {
  description = "Enable or Disable VPC Flow Logs (CloudWatch)"
  default     = false
  type        = bool
}

variable "vpc_name" {
  description = "Our VPC Tag Name"
  default     = "sandbox"
  type        = string
}
