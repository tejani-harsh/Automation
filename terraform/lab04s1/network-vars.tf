variable "resource_group_name" {
  type    = string
  default = "network-rg"
}

variable "location" {
  type    = string
  default = "Canada Central"
}

variable "virtual_network_name" {
  type    = string
  default = "network-vnet"
}


variable "virtual_network_name_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}
variable "subnet_names" {
  type    = list(string)
  default = ["network-subnet-1", "network-subnet-2"]
}

variable "subnet_address_space" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "network_security_group_names" {
  type    = list(string)
  default = ["network-sg1", "network-sg2"]
}
