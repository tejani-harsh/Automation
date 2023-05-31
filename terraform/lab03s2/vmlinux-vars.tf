locals {
  common_tags = {
    Name         = "Terraform-Class"
    Project      = "Learning"
    ContactEmail = "n01581156@humber.ca"
    Environment  = "Lab"

  }
}
variable "vm" {
  type = map(string)

  default = {
    name           = "n01581156-u-vm1"
    location       = "Canada Central"
    size           = "Standard_B1s"
    admin_username = "n01581156"
    public_key     = "/Users/harshtejani/.ssh/id_rsa.pub"
  }
}

variable "vm_os_disk" {
  type = map(string)

  default = {
    storage_type = "Premium_LRS"
    size         = "32"
    caching      = "ReadWrite"
  }
}

variable "vm_os" {
  type = map(string)

  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}