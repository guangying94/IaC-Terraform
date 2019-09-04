# Configure the Microsoft Azure Provider.
provider "azurerm" {
  version = "=1.30.0"
}

resource "azurerm_lb" "ilb" {
  name                = "ilb-${var.ilb-name}"
  location            = "${var.location}"
  resource_group_name = "${var.rg-name}"

  frontend_ip_configuration {
    name                          = "ilb-${var.ilb-name}-privateip"
    subnet_id                     = "${var.ilb-subnet-id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "ilb-bepool" {
  resource_group_name = "${var.rg-name}"
  loadbalancer_id     = "${azurerm_lb.ilb.id}"
  name                = "ilbbepool-${var.ilb-name}"
}

resource "azurerm_lb_probe" "ilb-probe" {
  resource_group_name = "${var.rg-name}"
  loadbalancer_id     = "${azurerm_lb.ilb.id}"
  name                = "probe-${var.ilb-name}"
  port                = 80
  protocol            = "Tcp"
  interval_in_seconds = 10
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "ilb-rule" {
  resource_group_name            = "${var.rg-name}"
  loadbalancer_id                = "${azurerm_lb.ilb.id}"
  name                           = "ilbrule-${var.ilb-name}"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.ilb-bepool.id}"
  frontend_ip_configuration_name = "ilb-${var.ilb-name}-privateip"
}