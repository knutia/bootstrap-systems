# p-exp-sub\rg_web\terragrunt.hcl
include {
  path = find_in_parent_folders()
}

locals {
  # Automatically load environment-level variables from files in parent folders
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl.txt"))
}

terraform {
  source = "git::https://${get_env("CI_REGISTRY_USER")}:${get_env("CI_REGISTRY_PASSWORD")}@gitlab.azure-pca.telenor.net/pca/tf-modules.git//modules/bootstrap_azure"
}

inputs = {
  subscription_id         = local.env_vars.locals.subscription_id
  resource_group_name     = "rg-web4"
  resource_group_location = "norwayeast"
  tags                    = local.env_vars.locals.tags
}
