terraform {
  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "terraformst126i4"
    container_name       = "tfstate"
    key                  = "system1"
  }
}
