# Configure the Microsoft Azure Provider.
provider "azurerm" {
  version = "=1.30.0"
}

##########
# Network rules
##########

# Create asg for each tier
module "azure-asg" {
  source   = "../modules/network/application-security-group"
  rg-name  = "${var.rg-name}"
  location = "${var.location}"
}

# Create nsg
module "azure-nsg" {
  source            = "../modules/network/nsg-intranet"
  rg-name           = "${var.rg-name}"
  location          = "${var.location}"
  jh-address        = "${var.jh-address}"
  appgw-subnet-cidr = "${var.appgw-subnet-cidr}"
  asg-web-id        = ["${module.azure-asg.asg-web-id}"]
  asg-app-id        = ["${module.azure-asg.asg-app-id}"]
  asg-db-id         = ["${module.azure-asg.asg-db-id}"]
  asg-it-id         = ["${module.azure-asg.asg-it-id}"]
  asg-gut-id        = ["${module.azure-asg.asg-gut-id}"]
}

##########
# Web tier
## Create in AZ 1 & 2
##########

# Create subnet
module "web-subnet" {
  source      = "../modules/network/subnet"
  rg-name     = "${var.rg-name}"
  vnet-name   = "${var.vnetname}"
  subnet-name = "web-${var.subnet-name}"
  subnet-cidr = "${var.web-subnet-cidr}"
}

#create nic
module "nic-web-1" {
  source        = "../modules/network/nic"
  rg-name       = "${var.rg-name}"
  location      = "${var.location}"
  nic-name      = "${var.web-nic-name}"
  nic-subnet-id = "${module.web-subnet.subnet-id}"
  nic-nsg-id    = "${module.azure-nsg.nsg-web-id}"
}

#create vm1
module "vm-web-1" {
  source          = "../modules/compute/linux-virtual-machine"
  rg-name         = "${var.rg-name}"
  location        = "${var.location}"
  nic-id          = "${module.nic-web-1.nic-id}"
  vm-name         = "${var.web-vm-name}"
  vm-size         = "${var.web-vm-size}"
  vm-az           = ["${var.web-vm-az[0]}"]
  image-publisher = "${var.web-vm-image-publisher}"
  image-offer     = "${var.web-vm-image-offer}"
  image-sku       = "${var.web-vm-image-sku}"
  image-version   = "${var.web-vm-image-version}"
  os-hostname     = "${var.web-os-hostname}"
  os-username     = "${var.web-os-username}"
  os-password     = "${var.web-os-password}"
  os-disk-type    = "${var.web-disk-type}"
  data-disk-size  = "${var.web-data-disk-size}"
  data-disk-type  = "${var.web-data-disk-type}"
}

#create nic2
module "nic-web-2" {
  source        = "../modules/network/nic"
  rg-name       = "${var.rg-name}"
  location      = "${var.location}"
  nic-name      = "${var.web-nic-name}"
  nic-subnet-id = "${module.web-subnet.subnet-id}"
  nic-nsg-id    = "${module.azure-nsg.nsg-web-id}"
}

#create vm2
module "vm-web-2" {
  source          = "../modules/compute/linux-virtual-machine"
  rg-name         = "${var.rg-name}"
  location        = "${var.location}"
  nic-id          = "${module.nic-web-2.nic-id}"
  vm-name         = "${var.web-vm-name}"
  vm-size         = "${var.web-vm-size}"
  vm-az           = ["${var.web-vm-az[1]}"]
  image-publisher = "${var.web-vm-image-publisher}"
  image-offer     = "${var.web-vm-image-offer}"
  image-sku       = "${var.web-vm-image-sku}"
  image-version   = "${var.web-vm-image-version}"
  os-hostname     = "${var.web-os-hostname}"
  os-username     = "${var.web-os-username}"
  os-password     = "${var.web-os-password}"
  os-disk-type    = "${var.web-disk-type}"
  data-disk-size  = "${var.web-data-disk-size}"
  data-disk-type  = "${var.web-data-disk-type}"
}

##########
# App GW tier
## to-do check how to create list if web tier is > 2
##########

# Create subnet
module "appgw-subnet" {
  source      = "../modules/network/subnet"
  rg-name     = "${var.rg-name}"
  vnet-name   = "${var.vnetname}"
  subnet-name = "appgw-${var.subnet-name}"
  subnet-cidr = "${var.appgw-subnet-cidr}"
}

# Create pip
module "public_ip" {
  source   = "../modules/network/pip"
  rg-name  = "${var.rg-name}"
  pip-name = "pip"
  location = "${var.location}"
}

# Create appgw-waf
module "appgw_waf" {
  source     = "../modules/network/application-gateway"
  rg-name    = "${var.rg-name}"
  appgw-name = "${var.appgw-name}"
  location   = "${var.location}"
  subnet-id  = "${module.appgw-subnet.subnet-id}"
  az-list    = ["1", "2"]
  pip-id     = "${module.public_ip.pip-id}"
  bepool-ip  = "${list("${module.nic-web-1.nic-ip}", "${module.nic-web-2.nic-ip}")}"
  behttp-port= "5000"
}

##########
# App tier
## to-do bepool for ilb
##########

# Create subnet
module "app-subnet" {
  source      = "../modules/network/subnet"
  rg-name     = "${var.rg-name}"
  vnet-name   = "${var.vnetname}"
  subnet-name = "app-${var.subnet-name}"
  subnet-cidr = "${var.app-subnet-cidr}"
}

#create nic1
module "nic-app-1" {
  source        = "../modules/network/nic"
  rg-name       = "${var.rg-name}"
  location      = "${var.location}"
  nic-name      = "${var.app-nic-name}"
  nic-subnet-id = "${module.app-subnet.subnet-id}"
  nic-nsg-id    = "${module.azure-nsg.nsg-app-id}"
}

#create vm1
module "vm-app-1" {
  source          = "../modules/compute/linux-virtual-machine"
  rg-name         = "${var.rg-name}"
  location        = "${var.location}"
  nic-id          = "${module.nic-app-1.nic-id}"
  vm-name         = "${var.app-vm-name}"
  vm-size         = "${var.app-vm-size}"
  vm-az           = ["${var.app-vm-az[0]}"]
  image-publisher = "${var.app-vm-image-publisher}"
  image-offer     = "${var.app-vm-image-offer}"
  image-sku       = "${var.app-vm-image-sku}"
  image-version   = "${var.app-vm-image-version}"
  os-hostname     = "${var.app-os-hostname}"
  os-username     = "${var.app-os-username}"
  os-password     = "${var.app-os-password}"
  os-disk-type    = "${var.app-disk-type}"
  data-disk-size  = "${var.app-data-disk-size}"
  data-disk-type  = "${var.app-data-disk-type}"
}

#create nic2
module "nic-app-2" {
  source        = "../modules/network/nic"
  rg-name       = "${var.rg-name}"
  location      = "${var.location}"
  nic-name      = "${var.app-nic-name}"
  nic-subnet-id = "${module.app-subnet.subnet-id}"
  nic-nsg-id    = "${module.azure-nsg.nsg-app-id}"
}

#create vm2
module "vm-app-2" {
  source          = "../modules/compute/linux-virtual-machine"
  rg-name         = "${var.rg-name}"
  location        = "${var.location}"
  nic-id          = "${module.nic-app-2.nic-id}"
  vm-name         = "${var.app-vm-name}"
  vm-size         = "${var.app-vm-size}"
  vm-az           = ["${var.app-vm-az[1]}"]
  image-publisher = "${var.app-vm-image-publisher}"
  image-offer     = "${var.app-vm-image-offer}"
  image-sku       = "${var.app-vm-image-sku}"
  image-version   = "${var.app-vm-image-version}"
  os-hostname     = "${var.app-os-hostname}"
  os-username     = "${var.app-os-username}"
  os-password     = "${var.app-os-password}"
  os-disk-type    = "${var.app-disk-type}"
  data-disk-size  = "${var.app-data-disk-size}"
  data-disk-type  = "${var.app-data-disk-type}"
}

#create ilb
module "app-ilb" {
  source        = "../modules/network/internal-lb"
  rg-name       = "${var.rg-name}"
  location      = "${var.location}"
  ilb-name      = "${var.app-ilb-name}"
  ilb-subnet-id = "${module.app-subnet.subnet-id}"
}

##########
# DB tier
## to-do add database
##########

# Create subnet
module "db-subnet" {
  source      = "../modules/network/subnet"
  rg-name     = "${var.rg-name}"
  vnet-name   = "${var.vnetname}"
  subnet-name = "db-${var.subnet-name}"
  subnet-cidr = "${var.db-subnet-cidr}"
}

#create nic1
module "nic-db-1" {
  source        = "../modules/network/nic"
  rg-name       = "${var.rg-name}"
  location      = "${var.location}"
  nic-name      = "${var.db-nic-name}"
  nic-subnet-id = "${module.db-subnet.subnet-id}"
  nic-nsg-id    = "${module.azure-nsg.nsg-db-id}"
}

#create vm1
module "vm-db-1" {
  source          = "../modules/compute/linux-virtual-machine"
  rg-name         = "${var.rg-name}"
  location        = "${var.location}"
  nic-id          = "${module.nic-db-1.nic-id}"
  vm-name         = "${var.db-vm-name}"
  vm-size         = "${var.db-vm-size}"
  vm-az           = ["${var.db-vm-az[0]}"]
  image-publisher = "${var.db-vm-image-publisher}"
  image-offer     = "${var.db-vm-image-offer}"
  image-sku       = "${var.db-vm-image-sku}"
  image-version   = "${var.db-vm-image-version}"
  os-hostname     = "${var.db-os-hostname}"
  os-username     = "${var.db-os-username}"
  os-password     = "${var.db-os-password}"
  os-disk-type    = "${var.db-disk-type}"
  data-disk-size  = "${var.db-data-disk-size}"
  data-disk-type  = "${var.db-data-disk-type}"
}

#create nic2
module "nic-db-2" {
  source        = "../modules/network/nic"
  rg-name       = "${var.rg-name}"
  location      = "${var.location}"
  nic-name      = "${var.db-nic-name}"
  nic-subnet-id = "${module.db-subnet.subnet-id}"
  nic-nsg-id    = "${module.azure-nsg.nsg-db-id}"
}

#create vm2
module "vm-db-2" {
  source          = "../modules/compute/linux-virtual-machine"
  rg-name         = "${var.rg-name}"
  location        = "${var.location}"
  nic-id          = "${module.nic-db-2.nic-id}"
  vm-name         = "${var.db-vm-name}"
  vm-size         = "${var.db-vm-size}"
  vm-az           = ["${var.db-vm-az[1]}"]
  image-publisher = "${var.db-vm-image-publisher}"
  image-offer     = "${var.db-vm-image-offer}"
  image-sku       = "${var.db-vm-image-sku}"
  image-version   = "${var.db-vm-image-version}"
  os-hostname     = "${var.db-os-hostname}"
  os-username     = "${var.db-os-username}"
  os-password     = "${var.db-os-password}"
  os-disk-type    = "${var.db-disk-type}"
  data-disk-size  = "${var.db-data-disk-size}"
  data-disk-type  = "${var.db-data-disk-type}"
}