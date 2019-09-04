provider "azurerm" {
  version = "=1.30.0"
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.subnet-name}"
  resource_group_name  = "${var.rg-name}"
  virtual_network_name = "${var.vnet-name}"
  address_prefix       = "${var.subnet-cidr}"
}

output "subnet-id" {
  value = "${azurerm_subnet.subnet.id}"
}