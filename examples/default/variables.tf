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

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags"
}
