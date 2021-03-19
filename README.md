# Bootstrap

## Background

The terraform resource group contains your Terraform bootstrap resources.

These include:

* a key vault containing the credentials for the service principal
* a storage account that includes
    * a tfstate container for holding your terraform.tfstate files
    * a bootstrap container that contains files to quickstart your Terraform configs
* a log analytics workspace to track access to the key vault

The files in this folder or container can be used in your Terraform root modules if you want to use the service principal and use the storage account to store your Terraform state.

Note that the files are setup for command line terraform execution, and will access the key vault using the user's credentials. The user principal must have a key vault access policy granted to read the secrets, or belong to a security group that does.

Additional information is provided for managed identity scenarios and for CI/CD pipelines.

## Directions

1. Context

  Check that you are in the correct Azure context, i.e. you are logged in as the right user and in the right subscription.

  For example:

  ```bash
  az account show
  az account list --output table
  az account set --subscription <subscriptionId>
  ```

1. Directory

  You should be in your Terraform root module. For example:

  ```bash
  mkdir ~/terraform-test && cd ~/terraform-test
  ```

1. Download the files

  Using the Azure CLI:
  ```bash
  az storage blob download --file azurerm_provider.tf  --account-name terraformst126i4 --container-name bootstrap --name azurerm_provider.tf --auth-mode login
  az storage blob download --file backend.tf           --account-name terraformst126i4 --container-name bootstrap --name backend.tf --auth-mode login
  az storage blob download --file bootstrap_secrets.tf --account-name terraformst126i4 --container-name bootstrap --name bootstrap_secrets.tf --auth-mode login
  ```

1. Edit the backend.tf

  The default value for the key in the backend.tf is an empty string, and you have to set it before running `terraform init`. This has been done intentionally so that there is a deliberate decision on the terraform state file name.

  ***IMPORTANT!***: **Ensure that the name doesn't conflict with any existing Terraform state files in the tfstate container.**

  Set the key value to be the desired name of the terraform statefile. E.g.

  * "terraform.tfstate"
  * "hub.tfstate"
  * "clientname/hub.tfstate"
  * "clientname-hub.tfstate"

  You will now be able to run through the terraform lifecycle commands and start building up your config.

  > If you ran `terraform init` whilst it was empty then see the the [troubleshooting](#troubleshooting) section.

## Managed Identity

If you are using trusted compute with a Managed Identity that has read access to the key vault secrets then set `use_msi = true` in the bootstrap_secrets.tf.

## CI/CD Pipelines

If you are using a CI/CD pipeline then:

* export [environment variables](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html#configuring-the-service-principal-in-terraform)
* Bash commands to export:

  ```bash
  export ARM_TENANT_ID=e6017ef7-e18e-41f2-a27f-6a5b1f9f7e1a
  export ARM_SUBSCRIPTION_ID=<subscriptionId> # E.g. $(az account show --output tsv --query id)
  export ARM_CLIENT_ID=98104319-e07b-4e18-965f-d868efd04324
  export ARM_CLIENT_SECRET=$(az keyvault secret show --vault-name terraformst126i4 --name client-secret --output tsv --query value)
  ```

* remove the matching attributes in azurerm_provider.tf
* the bootstrap_secrets.tf file is not required

## Troubleshooting

#### Ran terraform init before setting the Terraform state file name

1. Edit the backend.tf and change the key value fom an empty string to your desired terraform state file name
1. Clean up the .terraform/terraform.tfstate JSON file. Either
  * Delete the file
  * Edit the file and set the value for .backend.config.key
1. Rerun terraform init

