# Example: Default label generation (use_custom_name = false)
# The module generates the ID by joining label components.

module "label" {
  source = "../../"

  prefix      = "myorg"
  environment = "prod"
  type        = "app"
  name        = "web"

  tags = {
    BusinessUnit = "Engineering"
  }
}

output "id" {
  value = module.label.id
}

output "tags" {
  value = module.label.tags
}
