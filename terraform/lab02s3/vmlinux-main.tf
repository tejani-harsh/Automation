resource "azurerm_resource_group" "vm-rg" {
  name     = var.vm["name"]
  location = var.vm["location"]
}

resource "azurerm_network_interface" "vm-nic" {
  name                = "${var.vm["name"]}-nic"
  location            = azurerm_resource_group.vm-rg.location
  resource_group_name = azurerm_resource_group.vm-rg.name

  ip_configuration {
    name                          = "${var.vm["name"]}-ipconfig"
    subnet_id                     = azurerm_subnet.network-subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "vm-pip" {
  name                = "${var.vm["name"]}-pip"
  resource_group_name = azurerm_resource_group.vm-rg.name
  location            = azurerm_resource_group.vm-rg.location
  allocation_method   = "Dynamic"
}

resource "azurerm_linux_virtual_machine" "vm_instance" {
  name                = "${var.vm["name"]}-os-disk"
  resource_group_name = azurerm_resource_group.vm-rg.name
  location            = azurerm_resource_group.vm-rg.location
  size                = var.vm["size"]
  admin_username      = var.vm["admin_username"]
  network_interface_ids = [
    azurerm_network_interface.vm-nic.id,
  ]

  admin_ssh_key {
    username   = var.vm["admin_username"]
    public_key = file(var.vm["public_key"])
  }

  os_disk {
    disk_size_gb         = var.vm_os_disk["size"]
    caching              = var.vm_os_disk["caching"]
    storage_account_type = var.vm_os_disk["storage_type"]
  }

  source_image_reference {
    publisher = var.vm_os["publisher"]
    offer     = var.vm_os["offer"]
    sku       = var.vm_os["sku"]
    version   = var.vm_os["version"]
  }
}