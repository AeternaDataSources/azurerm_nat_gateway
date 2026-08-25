variable "nat_gateway_lookup" {
  description = <<EOT
Map of nat_gateway_lookup, attributes below
Required:
    - name
    - resource_group_name
Optional:
    - public_ip_address_ids
    - public_ip_prefix_ids
EOT

  type = map(object({
    name                  = string
    resource_group_name   = string
    public_ip_address_ids = optional(list(string))
    public_ip_prefix_ids  = optional(list(string))
  }))
  validation {
    condition = alltrue([
      for k, v in var.nat_gateway_lookup : (
        length(v.name) != 1
      )
    ])
    error_message = "[from validate.NatGatewayName: invalid when len(value) == 1]"
  }
  validation {
    condition = alltrue([
      for k, v in var.nat_gateway_lookup : (
        length(v.resource_group_name) <= 90
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) > 90]"
  }
  validation {
    condition = alltrue([
      for k, v in var.nat_gateway_lookup : (
        !endswith(v.resource_group_name, ".")
      )
    ])
    error_message = "[from resourcegroups.ValidateName: must not end with \".\"]"
  }
  validation {
    condition = alltrue([
      for k, v in var.nat_gateway_lookup : (
        length(v.resource_group_name) != 0
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) == 0]"
  }
  validation {
    condition = alltrue([
      for k, v in var.nat_gateway_lookup : (
        alltrue([for x in v.zones : length(x) > 0])
      )
    ])
    error_message = "must not be empty"
  }
  # Note: 4 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

