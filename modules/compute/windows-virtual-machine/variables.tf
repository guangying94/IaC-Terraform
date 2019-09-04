variable "rg-name" {
  type = "string"
}

variable "location" {
  type = "string"
}

variable "nic-id" {
  type = "string"
}

variable "vm-name" {
  type = "string"
}

variable "vm-size" {
  type    = "string"
  default = "Standard_DS1_v2"
}

variable "vm-az" {
  type    = "list"
  default = ["1"]
}

variable "image-publisher" {
  type    = "string"
  default = "Canonical"
}

variable "image-offer" {
  type    = "string"
  default = "UbuntuServer"
}

variable "image-sku" {
  type    = "string"
  default = "18.04-LTS"
}

variable "image-version" {
  type    = "string"
  default = "latest"
}

variable "os-hostname" {
  type    = "string"
  default = "hostname"
}

variable "os-username" {
  type    = "string"
  default = "testadmin"
}

variable "os-password" {
  type    = "string"
  default = "Password1234!"
}

variable "os-disk-type" {
  type    = "string"
  default = "StandardSSD_LRS"
}

variable "data-disk-size" {
  type    = "string"
  default = "128"
}

variable "data-disk-type" {
  type    = "string"
  default = "StandardSSD_LRS"
}