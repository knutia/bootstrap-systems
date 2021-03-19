provider "azurerm" {
  // Uses the Azure CLI token (or env vars) unless managed identity is used
  features {}
  alias   = "backend"
  use_msi = false
}

data "azurerm_key_vault_secret" "tenant_id" {
  provider     = azurerm.backend
  key_vault_id = "/subscriptions/ba95f1f6-eac8-4068-aa2d-45c70a99788c/resourceGroups/terraform/providers/Microsoft.KeyVault/vaults/terraformst126i4"
  name         = "tenant-id"
}

data "azurerm_key_vault_secret" "client_id" {
  provider     = azurerm.backend
  key_vault_id = "/subscriptions/ba95f1f6-eac8-4068-aa2d-45c70a99788c/resourceGroups/terraform/providers/Microsoft.KeyVault/vaults/terraformst126i4"
  name         = "client-id"
}

data "azurerm_key_vault_secret" "client_secret" {
  provider     = azurerm.backend
  key_vault_id = "/subscriptions/ba95f1f6-eac8-4068-aa2d-45c70a99788c/resourceGroups/terraform/providers/Microsoft.KeyVault/vaults/terraformst126i4"
  name         = "client-secret"
}
