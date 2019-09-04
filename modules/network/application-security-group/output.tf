output "asg-web-id" {
  value = "${azurerm_application_security_group.azure-asg-web.id}"
}

output "asg-app-id" {
  value = "${azurerm_application_security_group.azure-asg-app.id}"
}

output "asg-db-id" {
  value = "${azurerm_application_security_group.azure-asg-db.id}"
}

output "asg-gut-id" {
  value = "${azurerm_application_security_group.azure-asg-gut.id}"
}

output "asg-it-id" {
  value = "${azurerm_application_security_group.azure-asg-it.id}"
}