output "VmHostName" {
  value = azurerm_linux_virtual_machine.vm_instance.name
}
output "VmFQDN" {
  value = azurerm_public_ip.vm-pip.fqdn
}
output "PrivateIP" {
  value = azurerm_network_interface.vm-nic.private_ip_address
}
output "PublicIP" {
  value = azurerm_public_ip.vm-pip.ip_address
}
output "VirtualNetworkName" {
  value = azurerm_virtual_network.network-vnet.name
}
output "VmAddressSpace" {
  value = azurerm_virtual_network.network-vnet.address_space
}
output "SubnetName1" {
  value = azurerm_subnet.network-subnet1.name
}
output "AddressSpace1" {
  value = azurerm_subnet.network-subnet1.address_prefixes
}
output "SubnetName2" {
  value = azurerm_subnet.network-subnet2.name
}
output "AddressSpace2" {
  value = azurerm_subnet.network-subnet2.address_prefixes
}
