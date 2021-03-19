# p-exp-sub\terragrunt.hcl
#     subscription_id      = "34f7af6c-783f-4b8b-8685-fa3a9915e242"

remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    resource_group_name  = "terraform"
    storage_account_name = "terraformst126i4"
    container_name       = "tfstate"
    key                  = "p-exp-sub/${path_relative_to_include()}/terraform.tfstate"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
        provider "azurerm" {
        subscription_id = "ba95f1f6-eac8-4068-aa2d-45c70a99788c"
        features {}
        }
    EOF
}
