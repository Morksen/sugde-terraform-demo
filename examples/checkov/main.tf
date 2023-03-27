
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
    key                  = "checkov.tfstate"
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

resource "random_pet" "random" {

}

resource "azurerm_resource_group" "name" {
  name = "mpa-sugde-${random_pet.random}"
}

resource "azurerm_storage_account" "storage" {
  #checkov:skip=CKV_AZURE_59:Ensure that Storage accounts disallow public access
  name = substr(replace(lower("mpasugde${random_pet.random}"), "/[^a-z0-9]/", ""), 0, 24)
}
