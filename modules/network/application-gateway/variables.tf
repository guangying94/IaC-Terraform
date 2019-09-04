variable "rg-name" {
  type = "string"
}

variable "appgw-name" {
  type = "string"
}

variable "location" {
  type    = "string"
  default = "southeastasia"
}

variable "subnet-id" {
  type = "string"
}

variable "az-list" {
  type = "list"
}
variable "pip-id" {
  type = "string"
}

variable "bepool-ip" {
  type = "list"
}

variable "behttp-port" {
  type = "string"
}