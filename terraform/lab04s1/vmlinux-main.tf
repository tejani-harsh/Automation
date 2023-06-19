resource "azurerm_network_interface" "vm-nic" {
  count               = var.nb_count
  name                = "${var.vm["name"]}-nic${count.index}"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

  ip_configuration {
    name                          = "${var.vm["name"]}-ipconfig-${count.index}"
    subnet_id                     = azurerm_subnet.network-subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm-pip[count.index].id
  }
  tags = local.common_tags
  lifecycle {
    prevent_destroy = false

  }
}

resource "azurerm_public_ip" "vm-pip" {
  count               = var.nb_count
  name                = "${var.vm["name"]}-pip-${count.index}"
  resource_group_name = azurerm_resource_group.network-rg.name
  location            = azurerm_resource_group.network-rg.location
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.vm["name"]}-${count.index}"
  tags                = local.common_tags
  lifecycle {
    prevent_destroy = false

  }
}

resource "azurerm_linux_virtual_machine" "vm_instance" {
  count               = var.nb_count
  name                = "${var.vm["name"]}${count.index}-os-disk"
  resource_group_name = azurerm_resource_group.network-rg.name
  location            = azurerm_resource_group.network-rg.location
  size                = var.vm["size"]
  admin_username      = var.vm["admin_username"]
  network_interface_ids = [
    element(azurerm_network_interface.vm-nic[*].id, count.index + 1)
  ]

  admin_ssh_key {
    username   = var.vm["admin_username"]
    public_key = file(var.vm["public_key"])
  }

  os_disk {
    name                 = "${var.vm_os_disk["name"]}-${count.index}"
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

  tags = local.common_tags

  lifecycle {
    prevent_destroy = false
    # ignore_changes  = [tags, ]
  }

}

resource "azurerm_availability_set" "linux_avs" {
  name                         = var.linux_avs
  resource_group_name          = azurerm_resource_group.network-rg.name
  location                     = azurerm_resource_group.network-rg.location
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5

}