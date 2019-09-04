provider "azurerm" {
  version = "=1.30.0"
}

resource "random_string" "rnd" {
  length  = 4
  special = false
}

resource "azurerm_network_interface" "nic" {
  name                      = format("nic-%[1]s-%[2]s", var.nic-name, random_string.rnd.result)
  location                  = "${var.location}"
  resource_group_name       = "${var.rg-name}"
  network_security_group_id = "${var.nic-nsg-id}"

  ip_configuration {
    name                          = "nicconfig-${var.nic-name}"
    subnet_id                     = "${var.nic-subnet-id}"
    private_ip_address_allocation = "Dynamic"
  }
}

output "nic-id" {
  value = "${azurerm_network_interface.nic.id}"
}

output "nic-ip" {
  value = "${azurerm_network_interface.nic.private_ip_address}"
}
