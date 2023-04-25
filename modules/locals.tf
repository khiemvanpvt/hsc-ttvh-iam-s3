locals {
  common_name = "MDG-${var.department}-${var.environment}-${var.project_name}"
  common_tags = {
    "MDG:HOME:Creator"     = var.creator == "" ? data.aws_caller_identity.current.user_id : var.creator,
    "MDG:HOME:Manager"     = upper(var.department),
    "MDG:HOME:Project"     = title(var.project_name),
    "MDG:HOME:Environment" = lower(var.environment),
    "MDG:HOME:CreateTime"  = formatdate("YYYY-MM-DD'T'hh:mm:ss+07:00", timeadd(timestamp(), "7h")),
    "MDG:HOME:ExpireTime"  = var.resource_expire,
    "MDG:HOME:Role"        = title(var.role)
  }
}
