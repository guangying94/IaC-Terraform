output "nsg-web-id" {
  value = "${azurerm_network_security_group.nsg-web.id}"
}

output "nsg-app-id" {
  value = "${azurerm_network_security_group.nsg-app.id}"
}

output "nsg-db-id" {
  value = "${azurerm_network_security_group.nsg-db.id}"
}

output "nsg-gut-id" {
  value = "${azurerm_network_security_group.nsg-gut.id}"
}

output "nsg-it-id" {
  value = "${azurerm_network_security_group.nsg-it.id}"
}