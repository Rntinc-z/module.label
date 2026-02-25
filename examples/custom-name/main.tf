# Example: Custom name override (use_custom_name = true)
# The module skips label generation and uses the custom_name directly as the ID.

module "label" {
  source = "../../"

  prefix      = "myorg"
  environment = "prod"
  type        = "app"
  name        = "web"

  use_custom_name = true
  custom_name     = "my-fully-custom-resource-name"

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
