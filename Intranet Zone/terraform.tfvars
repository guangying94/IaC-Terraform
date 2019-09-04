# Setup

rg-name    = "<rg-name>"
location   = "southeastasia"
vnetname   = "<vnet-name>"
jh-address = "10.2.0.4"

# Web Tier

subnet-name            = "subnet"
web-subnet-cidr        = "10.1.0.16/28"
web-nic-name           = "web"
web-vm-name            = "web"
web-vm-size            = "Standard_DS1_v2"
web-vm-az              = ["1", "2"]
web-vm-image-publisher = "MicrosoftWindowsServer"
web-vm-image-offer     = "WindowsServer"
web-vm-image-sku       = "2016-Datacenter-Server-Core-smalldisk"
web-vm-image-version   = "latest"
web-os-hostname        = "host"
web-os-username        = "testadmin"
web-os-password        = "Password1234!"
web-disk-type          = "StandardSSD_LRS"
web-data-disk-size     = "128"
web-data-disk-type     = "StandardSSD_LRS"

# AppGW Tier

appgw-subnet-cidr = "10.1.0.0/28"
appgw-name        = "waf"
appgw-az-list     = ["1", "2"]

# App Tier

app-subnet-cidr        = "10.1.0.32/28"
app-nic-name           = "app"
app-ilb-name           = "appilb"
app-vm-name            = "app"
app-vm-size            = "Standard_DS1_v2"
app-vm-az              = ["1", "2"]
app-vm-image-publisher = "Canonical"
app-vm-image-offer     = "UbuntuServer"
app-vm-image-sku       = "18.04-LTS"
app-vm-image-version   = "latest"
app-os-hostname        = "host"
app-os-username        = "testadmin"
app-os-password        = "Password1234!"
app-disk-type          = "StandardSSD_LRS"
app-data-disk-size     = "128"
app-data-disk-type     = "StandardSSD_LRS"

# DB Tier

db-subnet-cidr        = "10.1.0.48/28"
db-nic-name           = "db"
db-vm-name            = "db"
db-vm-size            = "Standard_DS1_v2"
db-vm-az              = ["1", "2"]
db-vm-image-publisher = "Canonical"
db-vm-image-offer     = "UbuntuServer"
db-vm-image-sku       = "18.04-LTS"
db-vm-image-version   = "latest"
db-os-hostname        = "host"
db-os-username        = "testadmin"
db-os-password        = "Password1234!"
db-disk-type          = "StandardSSD_LRS"
db-data-disk-size     = "128"
db-data-disk-type     = "StandardSSD_LRS"

# GUT Tier

gut-subnet-cidr        = "10.1.0.64/29"
gut-nic-name           = "gut"
gut-vm-name            = "gut"
gut-vm-size            = "Standard_DS1_v2"
gut-vm-az              = ["1"]
gut-vm-image-publisher = "Canonical"
gut-vm-image-offer     = "UbuntuServer"
gut-vm-image-sku       = "18.04-LTS"
gut-vm-image-version   = "latest"
gut-os-hostname        = "host"
gut-os-username        = "testadmin"
gut-os-password        = "Password1234!"
gut-disk-type          = "StandardSSD_LRS"
gut-data-disk-size     = "128"
gut-data-disk-type     = "StandardSSD_LRS"

# IT Tier

it-subnet-cidr        = "10.1.0.72/29"
it-nic-name           = "it"
it-vm-name            = "it"
it-vm-size            = "Standard_DS1_v2"
it-vm-az              = ["1"]
it-vm-image-publisher = "Canonical"
it-vm-image-offer     = "UbuntuServer"
it-vm-image-sku       = "18.04-LTS"
it-vm-image-version   = "latest"
it-os-hostname        = "host"
it-os-username        = "testadmin"
it-os-password        = "Password1234!"
it-disk-type          = "StandardSSD_LRS"
it-data-disk-size     = "128"
it-data-disk-type     = "StandardSSD_LRS"