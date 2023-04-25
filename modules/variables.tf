variable "create_bucket" {
  type        = bool
  default     = true
  description = "Khai bao truoc, chua su dung bien nay !!!!"
}

variable "create_user" {
  type        = bool
  default     = true
  description = "Khai bao truoc, chua su dung bien nay !!!!"
}

variable "create_iam" {
  type        = bool
  default     = true
  description = "Khai bao truoc, chua su dung bien nay !!!!"
}

variable "environment" {
  type    = string
  default = "dev"
  validation {
    condition     = contains(["dev", "uat", "prod","test"], var.environment)
    error_message = "Yeu cau nhap dung ten moi truong"
  }
}

variable "project_name" {
  type    = string
  default = "sample"
}

variable "department" {
  type = string
  validation {
    condition     = contains(["cntt", "nhs","home"], var.department)
    error_message = "Nhap chinh xac ten phong ban"
  }
}

variable "resource_expire" {
  type    = string
  default = "Never"
  validation {
    condition     = try(formatdate("YYYY-MM-DD'T'hh:mm:ssZ", var.resource_expire), "Invalid") != "Invalid" || var.resource_expire == "Never"
    error_message = "Nhap chinh xac thoi gian hoac 'Never'"
  }
}

variable "creator" {
  type    = string
  default = ""
}

variable "role" {
  type = string
}
variable "kvtest" {
  accesskey = procees.env.accesskey
  secrectkey = procees.env.secretkey
}
