provider "azurerm" {
  storage_use_azuread = true

  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }

  tenant_id       = data.azurerm_key_vault_secret.tenant_id.value
  subscription_id = var.subscription_id
  client_id       = data.azurerm_key_vault_secret.client_id.value
  client_secret   = data.azurerm_key_vault_secret.client_secret.value
}
