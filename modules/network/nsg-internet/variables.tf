variable "rg-name" {
  type = "string"
}

variable "location" {
  type = "string"
}

variable "jh-address" {
  type = "string"
}

variable "appgw-subnet-cidr" {
  type = "string"
}
variable "asg-web-id" {
  type = "list"
}

variable "asg-app-id" {
  type = "list"
}

variable "asg-db-id" {
  type = "list"
}

variable "asg-it-id" {
  type = "list"
}

variable "asg-gut-id" {
  type = "list"
}
