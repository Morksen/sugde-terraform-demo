
data "http" "ip" {
  url = "https://ifconfig.me/ip"
}

data "azurerm_client_config" "current" {}
