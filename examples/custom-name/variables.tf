variable "prefix" {
  type        = string
  description = "Prefix for the label"
}

variable "environment" {
  type        = string
  description = "Environment, e.g. 'prod', 'staging', 'dev'"
}

variable "type" {
  type        = string
  description = "Type, e.g. 'shared', 'app'"
}

variable "name" {
  type        = string
  description = "Solution name, e.g. 'web' or 'jenkins'"
}

variable "use_custom_name" {
  type        = bool
  default     = false
  description = "Set to true to use custom_name directly as the resource ID"
}

variable "custom_name" {
  type        = string
  default     = ""
  description = "Custom name to use when use_custom_name is true"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags"
}
