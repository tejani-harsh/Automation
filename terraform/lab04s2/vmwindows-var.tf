variable "windows_avs" {
  default = "windows_avs_set"
}

variable "windows_vm" {
  type        = map(string)

  default = {
    n01581156-w-vm1 = "Standard_B1s"
    n01581156-w-vm2 = "Standard_B1ms"
  }
}
variable "windows_OS_disk" {
  type        = map(string)
  default = {
    storage_account_type = "StandardSSD_LRS"
    Disk_size            = "128"
    caching              = "ReadWrite"
  }
}
variable "windows_OS" {
  type        = map(string)
  default = {
    Publisher = "MicrosoftWindowsServer"
    Offer     = "WindowsServer"
    Sku       = "2016-Datacenter"
    Version   = "latest"
  }
}
variable "windows_username" {
  type        = string
  default     = "harsh-n01581156"
}
variable "windows_password" {
  type        = string
  default     = "WindowsP@ssw0rd"
}