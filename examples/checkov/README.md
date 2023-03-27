# Example of checkov usage

## Setup

- Install terraform
- Install AZ CLI
- Install Checkov or use the docker image

## Check terraform files

- Login to your azure tenant

- Execute `terraform init`
- Execute `terraform validate`
- Execute `terraform plan`

`terraform validate` and `terraform plan` should not output any errors. So basically the terraform config is valid

- Execute `checkov -d .`

Multiple checks should fail on the configured storage account.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.37 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~>3.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.49.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [random_pet.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rgname"></a> [rgname](#output\_rgname) | n/a |
| <a name="output_saname"></a> [saname](#output\_saname) | n/a |
<!-- END_TF_DOCS -->