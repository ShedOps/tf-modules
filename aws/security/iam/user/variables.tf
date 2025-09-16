variable "attach_group" {
  default = false
  type    = bool
}

variable "attach_policy" {
  default = false
  type    = bool
}

variable "user_group" {
  type = string
}

variable "user_name" {
  type = string
}

variable "user_path" {
  default = "/"
  type    = string
}

variable "user_policy" {
  default = null
  type    = string
}
