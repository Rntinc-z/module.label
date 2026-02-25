# Example: Default label generation (use_custom_name = false)
# The module generates the ID by joining label components.

module "label" {
  source = "../../"

  prefix      = var.prefix
  environment = var.environment
  type        = var.type
  name        = var.name
  tags        = var.tags
}
