provider "azurerm" {
  version = "=1.30.0"
}

resource "azurerm_application_security_group" "azure-asg-web" {
  name                = "asg-web"
  location            = "${var.location}"
  resource_group_name = "${var.rg-name}"
}

resource "azurerm_application_security_group" "azure-asg-app" {
  name                = "asg-app"
  location            = "${var.location}"
  resource_group_name = "${var.rg-name}"
}

resource "azurerm_application_security_group" "azure-asg-db" {
  name                = "asg-db"
  location            = "${var.location}"
  resource_group_name = "${var.rg-name}"
}

resource "azurerm_application_security_group" "azure-asg-gut" {
  name                = "asg-gut"
  location            = "${var.location}"
  resource_group_name = "${var.rg-name}"
}

resource "azurerm_application_security_group" "azure-asg-it" {
  name                = "asg-it"
  location            = "${var.location}"
  resource_group_name = "${var.rg-name}"
}