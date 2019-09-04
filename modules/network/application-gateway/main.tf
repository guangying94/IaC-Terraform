# Configure the Microsoft Azure Provider.
provider "azurerm" {
  version = "=1.30.0"
}

locals {
  backend_address_pool_name      = "${var.appgw-name}-beap"
  frontend_port_name             = "${var.appgw-name}-feport"
  frontend_ip_configuration_name = "${var.appgw-name}-feip"
  http_setting_name              = "${var.appgw-name}-be-htst"
  listener_name                  = "${var.appgw-name}-httplstn"
  request_routing_rule_name      = "${var.appgw-name}-rqrt"
  redirect_configuration_name    = "${var.appgw-name}-rdrcfg"
}

resource "azurerm_application_gateway" "network" {
  name                = "appgw-${var.appgw-name}"
  resource_group_name = "${var.rg-name}"
  location            = "${var.location}"
  zones               = ["1", "2"]

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = "${var.subnet-id}"
  }

  frontend_port {
    name = "${local.frontend_port_name}"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${local.frontend_ip_configuration_name}"
    public_ip_address_id = "${var.pip-id}"
  }

  backend_address_pool {
    name         = "${local.backend_address_pool_name}"
    ip_addresses = "${var.bepool-ip}"
  }

  backend_http_settings {
    name                  = "${local.http_setting_name}"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = "${var.behttp-port}"
    protocol              = "Http"
    request_timeout       = 10
  }

  http_listener {
    name                           = "${local.listener_name}"
    frontend_ip_configuration_name = "${local.frontend_ip_configuration_name}"
    frontend_port_name             = "${local.frontend_port_name}"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${local.request_routing_rule_name}"
    rule_type                  = "Basic"
    http_listener_name         = "${local.listener_name}"
    backend_address_pool_name  = "${local.backend_address_pool_name}"
    backend_http_settings_name = "${local.http_setting_name}"
  }
}