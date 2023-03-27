
resource "random_pet" "base" {

}

resource "azurerm_resource_group" "rg" {
  name     = "mpa-sugde-${random_pet.base.id}"
  location = var.location
}
