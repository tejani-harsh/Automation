provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "network-rg" {
  name     = "network-rg"
  location = "Canada Central"
}

resource "azurerm_network_security_group" "network-nsg1" {
  name                = "network-nsg1"
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
  name                = "network-nsg2"
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
  name                = "network-vnet"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  address_space       = ["10.0.0.0/16"]

}

resource "azurerm_subnet" "network-subnet1" {
  name                 = "network-subnet1"
  resource_group_name  = azurerm_resource_group.network-rg.name
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_subnet" "network-subnet2" {
  name                 = "network-subnet2"
  resource_group_name  = azurerm_resource_group.network-rg.name
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  address_prefixes     = ["10.0.2.0/24"]

}

resource "azurerm_subnet_network_security_group_association" "ng-sn-accoc" {
  subnet_id                 = azurerm_subnet.network-subnet1.id
  network_security_group_id = azurerm_network_security_group.network-nsg1.id
}

resource "azurerm_subnet_network_security_group_association" "ng2-sn2-accoc" {
  subnet_id                 = azurerm_subnet.network-subnet2.id
  network_security_group_id = azurerm_network_security_group.network-nsg2.id
}