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

output "web_app_url" {
  description = "The URL of the created web app"
  value       = azurerm_linux_web_app.demo.default_hostname
}

output "app_service_plan" {
  description = "The name of the created service plan"
  value       = azurerm_service_plan.demo.name
}

output "app_service_plan_sku" {
  description = "The name of the created service plan"
  value       = azurerm_service_plan.demo.sku_name
}

output "workspace" {
  value = terraform.workspace
}
