# Example: Custom name override (use_custom_name = true)
# The module skips label generation and uses the custom_name directly as the ID.

module "label" {
  source = "../../"

  prefix      = var.prefix
  environment = var.environment
  type        = var.type
  name        = var.name

  use_custom_name = var.use_custom_name
  custom_name     = var.custom_name

  tags = var.tags
}
