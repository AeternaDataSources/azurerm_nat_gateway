data "azurerm_nat_gateway" "nat_gateway_lookup" {
  for_each = var.nat_gateway_lookup

  name                  = each.value.name
  resource_group_name   = each.value.resource_group_name
  public_ip_address_ids = each.value.public_ip_address_ids
  public_ip_prefix_ids  = each.value.public_ip_prefix_ids
}

