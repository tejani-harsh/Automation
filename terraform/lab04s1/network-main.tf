resource "azurerm_resource_group" "network-rg" {
  name     = var.resource_group_name
  location = var.location
  # depends_on = [ azurerm_linux_virtual_machine.vm_instance ]
}

resource "azurerm_network_security_group" "network-nsg1" {
  name                = var.network_security_group_names[0]
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

  security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_network_security_group" "network-nsg2" {
  name                = var.network_security_group_names[1]
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

  security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "3389"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "rule2"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "5985"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


}


resource "azurerm_virtual_network" "network-vnet" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  address_space       = [var.virtual_network_name_address_space[0]]

}

resource "azurerm_subnet" "network-subnet1" {
  name                 = var.subnet_names[0]
  resource_group_name  = azurerm_resource_group.network-rg.name
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  address_prefixes     = [var.subnet_address_space[0]]

}

resource "azurerm_subnet" "network-subnet2" {
  name                 = var.subnet_names[1]
  resource_group_name  = azurerm_resource_group.network-rg.name
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  address_prefixes     = [var.subnet_address_space[1]]

}

resource "azurerm_subnet_network_security_group_association" "ng-sn-accoc" {
  subnet_id                 = azurerm_subnet.network-subnet1.id
  network_security_group_id = azurerm_network_security_group.network-nsg1.id
}

resource "azurerm_subnet_network_security_group_association" "ng2-sn2-accoc" {
  subnet_id                 = azurerm_subnet.network-subnet2.id
  network_security_group_id = azurerm_network_security_group.network-nsg2.id
}