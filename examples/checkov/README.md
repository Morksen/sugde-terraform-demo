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
