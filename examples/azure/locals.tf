locals {
  base_name = "sugde-${random_pet.base.id}"
  tags = merge(var.tags, {
    environment         = terraform.workspace,
    project             = var.project_name,
    managed_by          = "terraform",
    createdby_client_id = data.azurerm_client_config.current.client_id

  })
}
