# sugde-terraform-demo

##Terraform commands
`terraform init --backend-config=<path to tfbackend file>`
`terraform workspace list`
`terraform workspace select <name>`
`terraform plan --out=<name of tfplan>.tfplan`

## Checkov commands

`checkov -d <directory>`
`docker pull bridgecrew/checkov`
`docker run --rm --volume <directory>:/tf --workdir /tf bridgecrew checkov --directory /tf`
