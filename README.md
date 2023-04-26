# sugde-terraform-demo

## Terraform commands

`terraform init --backend-config=<path to tfbackend file>`
`terraform workspace list`
`terraform workspace select <name>`
`terraform plan --out=<name of tfplan>.tfplan`

## Checkov commands

`checkov -d <directory>`

```powershell
docker pull bridgecrew/checkov
$path = Resolve-Path .\examples\checkov\
docker run --rm --volume ${path}:/tf --workdir /tf bridgecrew/checkov --directory /tf
```
