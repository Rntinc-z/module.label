variable "prefix" {
  type        = string
  default     = ""
  description = "Prefix, any text you want at the beginning of the name"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'qa', 'uat'"
}

variable "type" {
  type        = string
  default     = ""
  description = "Type, e.g. 'shared', 'app'"
}

variable "name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. 'web' or 'jenkins'"
}

variable "override_region" {
  type        = string
  default     = null
  description = "if present use this region in label name"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `prefix`, `environment`, `type`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "additional_tag_map" {
  type        = map(string)
  default     = {}
  description = "Additional tags for appending to each tag map"
}

variable "context" {
  type = object({
    prefix              = string
    environment         = string
    type                = string
    name                = string
    enabled             = bool
    delimiter           = string
    attributes          = list(string)
    label_order         = list(string)
    tags                = map(string)
    additional_tag_map  = map(string)
    regex_replace_chars = string
  })
  default = {
    prefix              = ""
    environment         = ""
    type                = ""
    name                = ""
    enabled             = true
    delimiter           = ""
    attributes          = []
    label_order         = []
    tags                = {}
    additional_tag_map  = {}
    regex_replace_chars = ""
  }
  description = "Default context to use for passing state between label invocations"
}

variable "label_order" {
  type        = list(string)
  default     = []
  description = "The naming order of the id output and Name tag"
}

variable "regex_replace_chars" {
  type        = string
  default     = "/[^a-zA-Z0-9-]/"
  description = "Regex to replace chars with empty string in `prefix`, `environment`, `stage` and `name`. By default only hyphens, letters and digits are allowed, all other chars are removed"
}

variable "lowercase_name" {
  type        = bool
  default     = true
  description = "Set to false to allow custom uppercase names"
}

variable "use_custom_name" {
  type        = bool
  default     = false
  description = "Set to true to use `custom_name` directly as the resource ID, bypassing the label generation logic"
}

variable "custom_name" {
  type        = string
  default     = ""
  description = "Custom name to use as the resource ID when `use_custom_name` is true"
}

