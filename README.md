# module.label

Terraform module for generating consistent resource names and tags.

## Naming Convention

The default label format is:

```
{prefix}-{region}-{type}-{environment}-{name}-{attributes}
```

All components are optional. The delimiter and order are configurable via `delimiter` and `label_order`.

## Custom Name Override

Set `use_custom_name = true` and provide `custom_name` to bypass the label generation logic entirely and use your own name as the resource ID.

```hcl
module "label" {
  source = "github.com/Rntinc-z/module.label"

  use_custom_name = true
  custom_name     = "my-custom-resource-name"

  environment = "prod"
  tags        = { Team = "platform" }
}
```

When `use_custom_name` is `false` (the default), the module generates the ID from label components as usual.

## Usage

### Default (generated name)

```hcl
module "label" {
  source = "github.com/Rntinc-z/module.label"

  prefix      = "myorg"
  environment = "prod"
  type        = "app"
  name        = "web"
}

# output: id = "myorg-us-east-1-app-prod-web"
```

### Custom name

```hcl
module "label" {
  source = "github.com/Rntinc-z/module.label"

  prefix      = "myorg"
  environment = "prod"
  type        = "app"
  name        = "web"

  use_custom_name = true
  custom_name     = "my-fully-custom-resource-name"
}

# output: id = "my-fully-custom-resource-name"
```

### Passing context between modules

```hcl
module "base_label" {
  source      = "github.com/Rntinc-z/module.label"
  prefix      = "myorg"
  environment = "prod"
  type        = "app"
}

module "web_label" {
  source  = "github.com/Rntinc-z/module.label"
  context = module.base_label.context
  name    = "web"
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `prefix` | Text prepended to the name | `string` | `""` |
| `environment` | Environment, e.g. `prod`, `dev` | `string` | `""` |
| `type` | Resource type, e.g. `app`, `shared` | `string` | `""` |
| `name` | Solution name, e.g. `web`, `api` | `string` | `""` |
| `override_region` | Override the auto-detected AWS region | `string` | `null` |
| `enabled` | Set to `false` to disable the module | `bool` | `true` |
| `delimiter` | Delimiter between label components | `string` | `"-"` |
| `attributes` | Additional attributes appended to the name | `list(string)` | `[]` |
| `tags` | Additional tags to apply | `map(string)` | `{}` |
| `label_order` | Custom ordering of label components | `list(string)` | `[]` |
| `use_custom_name` | Use `custom_name` as the ID directly | `bool` | `false` |
| `custom_name` | Custom resource ID (requires `use_custom_name = true`) | `string` | `""` |
| `context` | Context object for passing state between labels | `object` | see `variables.tf` |
| `regex_replace_chars` | Regex for stripping invalid characters | `string` | `"/[^a-zA-Z0-9-]/"` |
| `lowercase_name` | Set to `false` to preserve uppercase in names | `bool` | `true` |
| `additional_tag_map` | Extra key-value pairs appended to each tag | `map(string)` | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `id` | Generated or custom resource ID |
| `name` | Normalized name |
| `region` | Resolved AWS region |
| `prefix` | Normalized prefix |
| `type` | Normalized type |
| `environment` | Normalized environment |
| `attributes` | List of attributes |
| `delimiter` | Delimiter used |
| `tags` | Merged tag map |
| `tags_as_list_of_maps` | Tags as a list of maps (for AWS resources) |
| `context` | Context object to pass to other label modules |
| `label_order` | Label ordering used |

## Requirements

- Terraform >= 0.12.0
- AWS provider

## License

MIT
