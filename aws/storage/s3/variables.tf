variable "acl" {
  description = "Canned ACL to apply"
  default     = "private"
  type        = string
}

variable "attach_policy" {
  default = true
  type    = bool
}

variable "bucket_name" {
  type = string
}

variable "create_test_key" {
  default = true
  type    = bool
}

variable "policy" {
  default = null
  type    = string
}

variable "versioning" {
  default = "Disabled"
  type    = string
}

variable "block_public_acls" {
  default = true
  type    = bool
}

variable "block_public_policy" {
  default = true
  type    = bool
}

variable "ignore_public_acls" {
  default = true
  type    = bool
}

variable "restrict_public_buckets" {
  default = true
  type    = bool
}

variable "sse_algorithm" {
  default = "aws:kms"
  type    = string
}

variable "kms_master_key_id" {
  default = null
  type    = string
}

variable "test_key" {
  default = null
  type    = string
}
