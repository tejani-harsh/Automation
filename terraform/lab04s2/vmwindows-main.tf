resource "azurerm_availability_set" "windows_availability_set" {
  name                         = var.windows_avs
  location                     = azurerm_resource_group.network-rg.location
  resource_group_name          = azurerm_resource_group.network-rg.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}
resource "azurerm_windows_virtual_machine" "windows_vm" {
  for_each              = var.windows_vm
  name                  = each.key
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = each.value
  network_interface_ids = [azurerm_network_interface.windows_nic[each.key].id]


  admin_username = var.windows_username
  admin_password = var.windows_password
  os_disk {
    name                 = "${each.key}-windows_OS_disk"
    caching              = var.windows_OS_disk.caching
    storage_account_type = var.windows_OS_disk.storage_account_type
    disk_size_gb         = var.windows_OS_disk.Disk_size
  }
  source_image_reference {
    publisher = var.windows_OS["Publisher"]
    offer     = var.windows_OS["Offer"]
    sku       = var.windows_OS["Sku"]
    version   = var.windows_OS["Version"]
  }
  winrm_listener {
    protocol = "Http"
  }
}

resource "azurerm_network_interface" "windows_nic" {
  for_each            = var.windows_vm
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${each.key}-ipconfig"
    subnet_id                     = azurerm_subnet.network-subnet2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows_vm_public_ip_name[each.key].id
  }
}
resource "azurerm_public_ip" "windows_vm_public_ip_name" {
  for_each            = var.windows_vm
  name                = "${each.key}-pip"
  resource_group_name = azurerm_resource_group.network-rg.name
  location            = azurerm_resource_group.network-rg.location
  allocation_method   = "Dynamic"
  domain_name_label   = "${each.key}"

}