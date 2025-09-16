variable "assume_role_policy_def" {
  type = string
}

variable "max_session_duration" {
  default = 43200
  type    = number
}
variable "policy_def" {
  type = string
}

variable "policy_name" {
  type = string
}

variable "role_name" {
  type = string
}
