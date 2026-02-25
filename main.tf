data "aws_region" "current" {}

locals {

  defaults = {
    label_order = ["prefix", "region", "type", "environment", "name", "attributes"]
    delimiter   = "-"
    replacement = ""
    # The `sentinel` should match the `regex_replace_chars`, so it will be replaced with the `replacement` value
    sentinel   = "~"
    attributes = [""]
  }

  # The values provided by variables superceed the values inherited from the context

  enabled             = var.enabled
  regex_replace_chars = coalesce(var.regex_replace_chars, var.context.regex_replace_chars)

  prefix             = lower(replace(coalesce(var.prefix, var.context.prefix, local.defaults.sentinel), local.regex_replace_chars, local.defaults.replacement))
  region             = var.override_region != null ? var.override_region : data.aws_region.current.name
  base_name          = replace(coalesce(var.name, var.context.name, local.defaults.sentinel), local.regex_replace_chars, local.defaults.replacement)
  name               = local.base_name
  environment        = lower(replace(coalesce(var.environment, var.context.environment, local.defaults.sentinel), local.regex_replace_chars, local.defaults.replacement))
  type               = lower(replace(coalesce(var.type, var.context.type, local.defaults.sentinel), local.regex_replace_chars, local.defaults.replacement))
  delimiter          = coalesce(var.delimiter, var.context.delimiter, local.defaults.delimiter)
  label_order        = length(var.label_order) > 0 ? var.label_order : (length(var.context.label_order) > 0 ? var.context.label_order : local.defaults.label_order)
  additional_tag_map = merge(var.context.additional_tag_map, var.additional_tag_map)

  # Merge attributes
  attributes = compact(distinct(concat(var.attributes, var.context.attributes, local.defaults.attributes)))



  tags_as_list_of_maps = flatten([
    for key in keys(local.tags) : merge(
      {
        key   = key
        value = local.tags[key]
    }, var.additional_tag_map)
  ])

  tags_context = {
    # For AWS we need `Name` to be disambiguated since it has a special meaning
    Name        = local.id
    environment = lower(local.environment)
    type        = lower(local.type)
  }
  tags = merge(var.context.tags, local.tags_context, var.tags)

  id_context = {
    prefix      = local.prefix
    region      = local.region
    name        = local.name
    environment = local.environment
    type        = local.type
    attributes  = lower(replace(join(local.delimiter, local.attributes), local.regex_replace_chars, local.defaults.replacement))
  }

  labels = [for l in local.label_order : local.id_context[l] if length(local.id_context[l]) > 0]

  base_id = join(local.delimiter, local.labels)
  id      = var.use_custom_name && var.custom_name != "" ? var.custom_name : local.base_id

  # Context of this label to pass to other label modules
  output_context = {
    enabled             = local.enabled
    prefix              = local.prefix
    region              = local.region
    name                = var.name
    environment         = local.environment
    type                = local.type
    attributes          = local.attributes
    tags                = local.tags
    delimiter           = local.delimiter
    label_order         = local.label_order
    regex_replace_chars = local.regex_replace_chars
    additional_tag_map  = local.additional_tag_map
  }

}
