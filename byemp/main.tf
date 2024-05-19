resource "azurerm_resource_group" "my-rg" {
  for_each = var.my-rg
  name     = each.value.name
  location = each.value.location
}

resource "azurerm_storage_account" "strg1" {
  for_each                 = var.strg
  name                     = each.key
  resource_group_name      = azurerm_resource_group.my-rg[each.value].name
  location                 = azurerm_resource_group.my-rg[each.value].location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}

# resource "azurerm_storage_container" "cont1" {
#   depends_on            = [azurerm_storage_account.strg1]
#   for_each              = var.cont
#   name                  = each.key
#   storage_account_name  = each.value.storage_account_name
#   container_access_type = each.value.container_access_type
# }