
data "http" "ip" {
  url = "https://ifconfig.me/ip"
}

data "azurerm_client_config" "current" {}

data "azurerm_storage_account_blob_container_sas" "http_logs" {
  connection_string = azurerm_storage_account.main.primary_connection_string
  container_name    = azurerm_storage_container.httplogs_container.name

  start  = timestamp()
  expiry = time_rotating.main.rotation_rfc3339

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }

  depends_on = [
    azurerm_storage_container.httplogs_container
  ]
}

data "azurerm_storage_account_blob_container_sas" "application_logs" {
  connection_string = azurerm_storage_account.main.primary_connection_string
  container_name    = azurerm_storage_container.walogs_container.name

  start  = timestamp()
  expiry = time_rotating.main.rotation_rfc3339

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }

  depends_on = [
    azurerm_storage_container.walogs_container
  ]
}
