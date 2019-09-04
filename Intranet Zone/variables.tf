variable "location" {
  type = "string"
}

variable "rg-name" {
  type = "string"
}

variable "vnetname" {
  type = "string"
}

variable "jh-address" {
  type = "string"
}

##########
## Setup for web tier
##########

variable "subnet-name" {
  type = "string"
}

variable "web-subnet-cidr" {
  type = "string"
}

variable "web-nic-name" {
  type = "string"
}

variable "web-vm-name" {
  type = "string"
}

variable "web-vm-size" {
  type = "string"
}

variable "web-vm-az" {
  type = "list"
}

variable "web-vm-image-publisher" {
  type = "string"
}

variable "web-vm-image-offer" {
  type = "string"
}

variable "web-vm-image-sku" {
  type = "string"
}

variable "web-vm-image-version" {
  type = "string"
}

variable "web-os-hostname" {
  type = "string"
}

variable "web-os-username" {
  type = "string"
}

variable "web-os-password" {
  type = "string"
}

variable "web-disk-type" {
  type = "string"
}

variable "web-data-disk-size" {
  type = "string"
}

variable "web-data-disk-type" {
  type = "string"
}

##########
## Setup for App GW
##########
variable "appgw-subnet-cidr" {
  type = "string"
}

variable "appgw-name" {
  type = "string"
}

variable "appgw-az-list" {
  type = "list"
}

##########
## Setup for app
##########

variable "app-subnet-cidr" {
  type = "string"
}

variable "app-nic-name" {
  type = "string"
}

variable "app-ilb-name" {
  type = "string"
}

variable "app-vm-name" {
  type = "string"
}

variable "app-vm-size" {
  type = "string"
}

variable "app-vm-az" {
  type = "list"
}

variable "app-vm-image-publisher" {
  type = "string"
}

variable "app-vm-image-offer" {
  type = "string"
}

variable "app-vm-image-sku" {
  type = "string"
}

variable "app-vm-image-version" {
  type = "string"
}

variable "app-os-hostname" {
  type = "string"
}

variable "app-os-username" {
  type = "string"
}

variable "app-os-password" {
  type = "string"
}

variable "app-disk-type" {
  type = "string"
}

variable "app-data-disk-size" {
  type = "string"
}

variable "app-data-disk-type" {
  type = "string"
}

##########
## Setup for db
##########

variable "db-subnet-cidr" {
  type = "string"
}

variable "db-nic-name" {
  type = "string"
}

variable "db-vm-name" {
  type = "string"
}

variable "db-vm-size" {
  type = "string"
}

variable "db-vm-az" {
  type = "list"
}

variable "db-vm-image-publisher" {
  type = "string"
}

variable "db-vm-image-offer" {
  type = "string"
}

variable "db-vm-image-sku" {
  type = "string"
}

variable "db-vm-image-version" {
  type = "string"
}

variable "db-os-hostname" {
  type = "string"
}

variable "db-os-username" {
  type = "string"
}

variable "db-os-password" {
  type = "string"
}

variable "db-disk-type" {
  type = "string"
}

variable "db-data-disk-size" {
  type = "string"
}

variable "db-data-disk-type" {
  type = "string"
}

##########
## Setup for gut
##########

variable "gut-subnet-cidr" {
  type = "string"
}

variable "gut-nic-name" {
  type = "string"
}

variable "gut-vm-name" {
  type = "string"
}

variable "gut-vm-size" {
  type = "string"
}

variable "gut-vm-az" {
  type = "list"
}

variable "gut-vm-image-publisher" {
  type = "string"
}

variable "gut-vm-image-offer" {
  type = "string"
}

variable "gut-vm-image-sku" {
  type = "string"
}

variable "gut-vm-image-version" {
  type = "string"
}

variable "gut-os-hostname" {
  type = "string"
}

variable "gut-os-username" {
  type = "string"
}

variable "gut-os-password" {
  type = "string"
}

variable "gut-disk-type" {
  type = "string"
}

variable "gut-data-disk-size" {
  type = "string"
}

variable "gut-data-disk-type" {
  type = "string"
}

##########
## Setup for it
##########

variable "it-subnet-cidr" {
  type = "string"
}

variable "it-nic-name" {
  type = "string"
}

variable "it-vm-name" {
  type = "string"
}

variable "it-vm-size" {
  type = "string"
}

variable "it-vm-az" {
  type = "list"
}

variable "it-vm-image-publisher" {
  type = "string"
}

variable "it-vm-image-offer" {
  type = "string"
}

variable "it-vm-image-sku" {
  type = "string"
}

variable "it-vm-image-version" {
  type = "string"
}

variable "it-os-hostname" {
  type = "string"
}

variable "it-os-username" {
  type = "string"
}

variable "it-os-password" {
  type = "string"
}

variable "it-disk-type" {
  type = "string"
}

variable "it-data-disk-size" {
  type = "string"
}

variable "it-data-disk-type" {
  type = "string"
}