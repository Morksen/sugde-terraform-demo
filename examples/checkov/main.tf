
terraform {

  required_version = ">=1.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.37"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.4"
    }
  }
  backend "azurerm" {
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = ""
    key                  = "checkov-example.tfstate"
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    app_configuration {
      purge_soft_delete_on_destroy = true
    }
    key_vault {
      purge_soft_delete_on_destroy = false
    }
    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }
  }
}

variable "location" {
  default = "westeurope"
}

resource "random_pet" "random" {

}

resource "azurerm_resource_group" "rg" {
  name     = "mpa-sugde-${random_pet.random.id}"
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  #checkov:skip=CKV_AZURE_59:Ensure that Storage accounts disallow public access
  name                     = substr(replace(lower("mpasugde${random_pet.random.id}"), "/[^a-z0-9]/", ""), 0, 24)
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

output "rgname" {
  value = azurerm_resource_group.rg.name
}

output "saname" {
  value = azurerm_storage_account.storage.name
}
