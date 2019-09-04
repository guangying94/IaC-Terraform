provider "azurerm" {
  version = "=1.30.0"
}

resource "azurerm_network_security_group" "nsg-web" {
  name                = "nsg-web"
  location            = "${var.location}"
  resource_group_name = "${var.rg-name}"

  security_rule {
    name                                       = "allow-web-app"
    priority                                   = 100
    direction                                  = "Outbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    source_application_security_group_ids      = "${var.asg-web-id}"
    destination_application_security_group_ids = "${var.asg-app-id}"
  }

  security_rule {
    name                                  = "block-outbound-internet"
    priority                              = 110
    direction                             = "Outbound"
    access                                = "Deny"
    protocol                              = "*"
    source_port_range                     = "*"
    destination_port_range                = "*"
    source_application_security_group_ids = "${var.asg-web-id}"
    destination_address_prefix            = "Internet"
  }

  security_rule {
    name                                  = "block-others"
    priority                              = 120
    direction                             = "Outbound"
    access                                = "Deny"
    protocol                              = "*"
    source_port_range                     = "*"
    destination_port_range                = "*"
    source_application_security_group_ids = "${var.asg-web-id}"
    destination_address_prefix            = "VirtualNetwork"
  }

  security_rule {
    name                                       = "block-inbound-internet"
    priority                                   = 100
    direction                                  = "Inbound"
    access                                     = "Deny"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-web-id}"
    source_address_prefix                      = "Internet"
  }

  security_rule {
    name                                       = "allow-jh-web"
    priority                                   = 110
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-web-id}"
    source_address_prefix                      = "${var.jh-address}"
  }

  security_rule {
    name                                       = "allow-appgw-web"
    priority                                   = 120
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-web-id}"
    source_address_prefix                      = "${var.appgw-subnet-cidr}"
  }

  security_rule {
    name                                       = "block-inbound-vnet"
    priority                                   = 130
    direction                                  = "Inbound"
    access                                     = "Deny"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-web-id}"
    source_address_prefix                      = "VirtualNetwork"
  }
}

resource "azurerm_network_security_group" "nsg-app" {
  name                = "nsg-app"
  location            = "${var.location}"
  resource_group_name = "${var.rg-name}"

  security_rule {
    name                                       = "allow-app-db"
    priority                                   = 100
    direction                                  = "Outbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    source_application_security_group_ids      = "${var.asg-app-id}"
    destination_application_security_group_ids = "${var.asg-db-id}"
  }

  security_rule {
    name                                       = "allow-app-it"
    priority                                   = 110
    direction                                  = "Outbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    source_application_security_group_ids      = "${var.asg-app-id}"
    destination_application_security_group_ids = "${var.asg-it-id}"
  }

  security_rule {
    name                                  = "block-internet-outbound"
    priority                              = 120
    direction                             = "Outbound"
    access                                = "Deny"
    protocol                              = "*"
    source_port_range                     = "*"
    destination_port_range                = "*"
    source_application_security_group_ids = "${var.asg-app-id}"
    destination_address_prefix            = "Internet"
  }

  security_rule {
    name                                  = "block-vnet-outbound"
    priority                              = 130
    direction                             = "Outbound"
    access                                = "Deny"
    protocol                              = "*"
    source_port_range                     = "*"
    destination_port_range                = "*"
    source_application_security_group_ids = "${var.asg-web-id}"
    destination_address_prefix            = "VirtualNetwork"
  }

  security_rule {
    name                                       = "block-internet-inbound"
    priority                                   = 100
    direction                                  = "Inbound"
    access                                     = "Deny"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-app-id}"
    source_address_prefix                      = "Internet"
  }

  security_rule {
    name                                       = "allow-web-app"
    priority                                   = 110
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    source_application_security_group_ids      = "${var.asg-web-id}"
    destination_application_security_group_ids = "${var.asg-app-id}"
  }

  security_rule {
    name                                       = "allow-jh-app"
    priority                                   = 120
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-app-id}"
    source_address_prefix                      = "${var.jh-address}"
  }

  security_rule {
    name                                       = "block-vnet-inbound"
    priority                                   = 130
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    source_address_prefix                      = "VirtualNetwork"
    destination_application_security_group_ids = "${var.asg-app-id}"
  }
}

resource "azurerm_network_security_group" "nsg-db" {
  name                = "nsg-db"
  location            = "${var.location}"
  resource_group_name = "${var.rg-name}"

  security_rule {
    name                                  = "block-internet-outbound"
    priority                              = 100
    direction                             = "Outbound"
    access                                = "Deny"
    protocol                              = "*"
    source_port_range                     = "*"
    destination_port_range                = "*"
    source_application_security_group_ids = "${var.asg-db-id}"
    destination_address_prefix            = "Internet"
  }

  security_rule {
    name                                  = "block-vnet-outbound"
    priority                              = 110
    direction                             = "Outbound"
    access                                = "Deny"
    protocol                              = "*"
    source_port_range                     = "*"
    destination_port_range                = "*"
    source_application_security_group_ids = "${var.asg-db-id}"
    destination_address_prefix            = "VirtualNetwork"
  }

  security_rule {
    name                                       = "block-internet-inbound"
    priority                                   = 100
    direction                                  = "Inbound"
    access                                     = "Deny"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-db-id}"
    source_address_prefix                      = "Internet"
  }

  security_rule {
    name                                       = "allow-app-db"
    priority                                   = 110
    direction                                  = "Inbound"
    access                                     = "Deny"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-db-id}"
    source_application_security_group_ids      = "${var.asg-app-id}"
  }

  security_rule {
    name                                       = "allow-jh-db"
    priority                                   = 120
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-db-id}"
    source_address_prefix                      = "${var.jh-address}"
  }

  security_rule {
    name                                       = "block-vnet-inbound"
    priority                                   = 130
    direction                                  = "Inbound"
    access                                     = "Deny"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-db-id}"
    source_address_prefix                      = "VirtualNetwork"
  }
}

resource "azurerm_network_security_group" "nsg-gut" {
  name                = "nsg-gut"
  location            = "${var.location}"
  resource_group_name = "${var.rg-name}"

  security_rule {
    name                                  = "allow-internet-outbound"
    priority                              = 100
    direction                             = "Outbound"
    access                                = "Allow"
    protocol                              = "*"
    source_port_range                     = "*"
    destination_port_range                = "*"
    source_application_security_group_ids = "${var.asg-gut-id}"
    destination_address_prefix            = "Internet"
  }

  security_rule {
    name                                  = "block-vnet-outbound"
    priority                              = 110
    direction                             = "Outbound"
    access                                = "Deny"
    protocol                              = "*"
    source_port_range                     = "*"
    destination_port_range                = "*"
    source_application_security_group_ids = "${var.asg-gut-id}"
    destination_address_prefix            = "VirtualNetwork"
  }

  security_rule {
    name                                       = "block-internet-inbound"
    priority                                   = 100
    direction                                  = "Inbound"
    access                                     = "Deny"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-gut-id}"
    source_address_prefix                      = "Internet"
  }

  security_rule {
    name                                       = "allow-it-gut"
    priority                                   = 110
    direction                                  = "Inbound"
    access                                     = "Deny"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-gut-id}"
    source_application_security_group_ids      = "${var.asg-it-id}"
  }

  security_rule {
    name                                       = "allow-jh-gut"
    priority                                   = 120
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-gut-id}"
    source_address_prefix                      = "${var.jh-address}"
  }

  security_rule {
    name                                       = "block-vnet-inbound"
    priority                                   = 130
    direction                                  = "Inbound"
    access                                     = "Deny"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-gut-id}"
    source_address_prefix                      = "VirtualNetwork"
  }
}

resource "azurerm_network_security_group" "nsg-it" {
  name                = "nsg-it"
  location            = "${var.location}"
  resource_group_name = "${var.rg-name}"

  security_rule {
    name                                  = "block-internet-outbound"
    priority                              = 100
    direction                             = "Outbound"
    access                                = "Deny"
    protocol                              = "*"
    source_port_range                     = "*"
    destination_port_range                = "*"
    source_application_security_group_ids = "${var.asg-it-id}"
    destination_address_prefix            = "Internet"
  }

  security_rule {
    name                                       = "allow-it-gut"
    priority                                   = 110
    direction                                  = "Outbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    source_application_security_group_ids      = "${var.asg-it-id}"
    destination_application_security_group_ids = "${var.asg-gut-id}"
  }

  security_rule {
    name                                  = "block-vnet-outbound"
    priority                              = 120
    direction                             = "Outbound"
    access                                = "Deny"
    protocol                              = "*"
    source_port_range                     = "*"
    destination_port_range                = "*"
    source_application_security_group_ids = "${var.asg-it-id}"
    destination_address_prefix            = "VirtualNetwork"
  }

  security_rule {
    name                                       = "block-internet-inbound"
    priority                                   = 100
    direction                                  = "Inbound"
    access                                     = "Deny"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-it-id}"
    source_address_prefix                      = "Internet"
  }

  security_rule {
    name                                       = "allow-app-it"
    priority                                   = 110
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-it-id}"
    source_application_security_group_ids      = "${var.asg-app-id}"
  }

  security_rule {
    name                                       = "allow-jh-it"
    priority                                   = 120
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-it-id}"
    source_address_prefix                      = "${var.jh-address}"
  }

  security_rule {
    name                                       = "block-vnet-inbound"
    priority                                   = 130
    direction                                  = "Inbound"
    access                                     = "Deny"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    destination_application_security_group_ids = "${var.asg-it-id}"
    source_address_prefix                      = "VirtualNetwork"
  }
}