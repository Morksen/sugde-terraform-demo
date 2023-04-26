
resource "random_pet" "base" {
  keepers = {
    workspace = terraform.workspace
  }
}

resource "time_rotating" "main" {
  rotation_rfc3339 = null
  rotation_years   = 2

  triggers = {
    end_date = null
    years    = 2
  }
}

resource "azurerm_resource_group" "main" {
  name     = "${local.base_name}-main-rg"
  location = var.location
  tags     = local.tags

  depends_on = [
    random_pet.base
  ]
}

resource "azurerm_storage_account" "main" {
  name                     = substr(replace("${local.base_name}mainsa", "/[^a-z0-9]+/", ""), 0, 24)
  location                 = azurerm_resource_group.main.location
  resource_group_name      = azurerm_resource_group.main.name
  tags                     = local.tags
  account_tier             = ("${terraform.workspace}" == "default") ? "Premium" : "Standard"
  account_replication_type = ("${terraform.workspace}" == "default") ? "ZRS" : "LRS"
}

resource "azurerm_storage_container" "walogs_container" {
  name                  = "application-logs"
  container_access_type = "private"
  storage_account_name  = azurerm_storage_account.main.name
}

resource "azurerm_storage_container" "httplogs_container" {
  name                  = "http-logs"
  container_access_type = "private"
  storage_account_name  = azurerm_storage_account.main.name
}

# resource "azurerm_storage_account" "demo" {
#   name                     = substr(replace("${local.base_name}demosa", "/[^a-z0-9]+/", ""), 0, 24)
#   location                 = azurerm_resource_group.main.location
#   resource_group_name      = azurerm_resource_group.main.name
#   tags                     = local.tags
#   account_tier             = ("${terraform.workspace}" == "default") ? "Premium" : "Standard"
#   account_replication_type = ("${terraform.workspace}" == "default") ? "ZRS" : "LRS"
# }

resource "azurerm_log_analytics_workspace" "main" {
  name                = "${local.base_name}-main-laws"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_linked_storage_account" "example" {
  data_source_type      = "CustomLogs"
  resource_group_name   = azurerm_resource_group.main.name
  workspace_resource_id = azurerm_log_analytics_workspace.main.id
  storage_account_ids   = [azurerm_storage_account.main.id]
}

resource "azurerm_service_plan" "demo" {
  name                = "${local.base_name}-demo-asp"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = ("${terraform.workspace}" == "default") ? "S1" : "B1"

}

resource "azurerm_linux_web_app" "demo" {
  name                = "${local.base_name}-demo-lwa"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_service_plan.demo.location
  service_plan_id     = azurerm_service_plan.demo.id

  logs {
    application_logs {
      azure_blob_storage {
        retention_in_days = 30
        level             = ("${terraform.workspace}" == "default") ? "Warning" : "Information"
        sas_url           = format("https://${azurerm_storage_account.main.name}.blob.core.windows.net/${azurerm_storage_container.walogs_container.name}%s", data.azurerm_storage_account_blob_container_sas.application_logs.sas)
      }
      file_system_level = ("${terraform.workspace}" == "default") ? "Warning" : "Information"
    }

    http_logs {
      azure_blob_storage {
        retention_in_days = 30
        sas_url           = format("https://${azurerm_storage_account.main.name}.blob.core.windows.net/${azurerm_storage_container.httplogs_container.name}%s", data.azurerm_storage_account_blob_container_sas.http_logs.sas)
      }
    }
  }

  site_config {
    application_stack {
      docker_image     = "registry.hub.docker.com/nginxdemos/hello"
      docker_image_tag = "latest"
    }
    ftps_state        = "FtpsOnly" #"Disabled"
    http2_enabled     = true
    health_check_path = "/status"
    auto_heal_enabled = true

    auto_heal_setting {

    }
  }
}
