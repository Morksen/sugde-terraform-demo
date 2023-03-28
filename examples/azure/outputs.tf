output "resource_group_name" {
  description = "The name of the created main resource group"
  value       = azurerm_resource_group.main.name
}

output "storage_account_name" {
  description = "The name of the created main storage account"
  value       = azurerm_storage_account.main.name
}

output "log_analytics_workspace" {
  description = "The name of the created main log analytics workspace"
  value       = azurerm_log_analytics_workspace.main.name
}
