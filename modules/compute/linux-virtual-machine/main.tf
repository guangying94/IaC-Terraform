provider "azurerm" {
  version = "=1.30.0"
}

resource "random_string" "rnd" {
  length  = 3
  special = false
}

resource "random_integer" "lun" {
  min = 0
  max = 15
}

resource "azurerm_virtual_machine" "main" {
  name                  = "vm-${var.vm-name}-${random_string.rnd.result}"
  location              = "${var.location}"
  resource_group_name   = "${var.rg-name}"
  network_interface_ids = ["${var.nic-id}"]
  vm_size               = "${var.vm-size}"
  zones                 = "${var.vm-az}"

  delete_os_disk_on_termination = true

  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "${var.image-publisher}"
    offer     = "${var.image-offer}"
    sku       = "${var.image-sku}"
    version   = "${var.image-version}"
  }

  storage_os_disk {
    name              = "osdisk-${var.vm-name}-${random_string.rnd.result}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "${var.os-disk-type}"
  }

  os_profile {
    computer_name  = "${var.os-hostname}"
    admin_username = "${var.os-username}"
    admin_password = "${var.os-password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_data_disk {
    name              = "datadisk-${var.vm-name}-${random_string.rnd.result}"
    caching           = "ReadWrite"
    create_option     = "Empty"
    disk_size_gb      = "${var.data-disk-size}"
    lun               = "${random_integer.lun.result}"
    managed_disk_type = "${var.data-disk-type}"
  }

}