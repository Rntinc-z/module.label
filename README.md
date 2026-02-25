# ist.terraform.module.label

     __          ___      .______    _______  __
    |  |        /   \     |   _  \  |   ____||  |
    |  |       /  ^  \    |  |_)  | |  |__   |  |
    |  |      /  /_\  \   |   _  <  |   __|  |  |
    |  `----./  _____  \  |  |_)  | |  |____ |  `----.
    |_______/__/     \__\ |______/  |_______||_______|

---

Terraform module designed to generate consistent names and tags for resources. Use `label` to implement a standard naming convention.

A label follows the following convention: `{prefix}-{region}-{type}-{environment}-{name}-{attributes}`. The delimiter (e.g. `-`) is interchangeable.
The label items are all optional. So if you don't want `prefix` and `region` for a particular resource you can exclude it and the label `id` will look like `{type}-{environment}-{name}-{attributes}`.

The order of the label can be customized as well for a particular resource.

```hcl
label_order = ["region", "name", "type", "environment", "attributes"]
```

It's recommended to use one `label` module for every unique resource of a given resource type.
For example, if you have 10 terraform resources, there should be 10 different labels.

## Examples

```hcl
module "vpc" {
  source      = "git::https://mk:{access token}@dev.azure.com/marykay/MK%20IaC/_git/ist.terraform.module.label?ref=0.17.0"
  region      = var.aws_region
  name        = "vpc"
  type        = var.type
  environment = var.environment
  delimiter   = var.delimiter
  attributes  = var.attributes
  tags        = var.tags
  label_order = ["region", "name", "type", "environment", "attributes"]
}
```

```hcl
module "ec2" {
  source      = "git::https://mk:{access token}@dev.azure.com/marykay/MK%20IaC/_git/ist.terraform.module.label?ref=0.17.0"
  prefix      = var.os
  region      = var.aws_region
  name        = var.app
  type        = var.type
  environment = var.environment
  delimiter   = var.delimiter
  attributes  = var.attributes
  tags        = var.tags
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional tags for appending to each tag map | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Default context to use for passing state between label invocations | <pre>object({<br>    prefix              = string<br>    environment         = string<br>    type                = string<br>    name                = string<br>    enabled             = bool<br>    delimiter           = string<br>    attributes          = list(string)<br>    label_order         = list(string)<br>    tags                = map(string)<br>    additional_tag_map  = map(string)<br>    regex_replace_chars = string<br>  })</pre> | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": "",<br>  "enabled": true,<br>  "environment": "",<br>  "label_order": [],<br>  "name": "",<br>  "prefix": "",<br>  "regex_replace_chars": "",<br>  "tags": {},<br>  "type": ""<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `prefix`, `environment`, `type`, `name` and `attributes` | `string` | `"-"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'prod', 'staging', 'dev', 'qa', 'uat' | `string` | `""` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The naming order of the id output and Name tag | `list(string)` | `[]` | no |
| <a name="input_lowercase_name"></a> [lowercase\_name](#input\_lowercase\_name) | Set to false to allow custom uppercase names | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Solution name, e.g. 'web' or 'jenkins' | `string` | `""` | no |
| <a name="input_override_region"></a> [override\_region](#input\_override\_region) | if present use this region in label name | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix, any text you want at the beginning of the name | `string` | `""` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Regex to replace chars with empty string in `prefix`, `environment`, `stage` and `name`. By default only hyphens, letters and digits are allowed, all other chars are removed | `string` | `"/[^a-zA-Z0-9-]/"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | Type, e.g. 'shared', 'app' | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_attributes"></a> [attributes](#output\_attributes) | List of attributes |
| <a name="output_context"></a> [context](#output\_context) | Context of this module to pass to other label modules |
| <a name="output_delimiter"></a> [delimiter](#output\_delimiter) | Delimiter between `prefix`, `environment`, `type`, `name` and `attributes` |
| <a name="output_environment"></a> [environment](#output\_environment) | Normalized environment |
| <a name="output_id"></a> [id](#output\_id) | Disambiguated ID |
| <a name="output_label_order"></a> [label\_order](#output\_label\_order) | The naming order of the id output and Name tag |
| <a name="output_name"></a> [name](#output\_name) | Normalized name |
| <a name="output_prefix"></a> [prefix](#output\_prefix) | Normalized prefix |
| <a name="output_region"></a> [region](#output\_region) | Normalized region |
| <a name="output_tags"></a> [tags](#output\_tags) | Normalized Tag map |
| <a name="output_tags_as_list_of_maps"></a> [tags\_as\_list\_of\_maps](#output\_tags\_as\_list\_of\_maps) | Additional tags as a list of maps, which can be used in several AWS resources |
| <a name="output_type"></a> [type](#output\_type) | Normalized type |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
