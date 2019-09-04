provider "azurerm" {
  version = "=1.30.0"
}

resource "azurerm_public_ip" "public-ip" {
  name                = "pip-${var.pip-name}"
  resource_group_name = "${var.rg-name}"
  location            = "${var.location}"
  allocation_method   = "Static"
  sku                 = "Standard"
}

output "pip-id" {
  value = "${azurerm_public_ip.public-ip.id}"
}