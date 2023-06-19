output "VmHostName" {
  value = azurerm_linux_virtual_machine.vm_instance[*].name
}
output "VmFQDN" {
  value = azurerm_public_ip.vm-pip[*].fqdn
}
output "PrivateIP" {
  value = azurerm_network_interface.vm-nic[*].private_ip_address
}
output "PublicIP" {
  value = azurerm_public_ip.vm-pip[*].ip_address
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
output "linux_avs" {
  value = azurerm_availability_set.linux_avs.name
}


output "windows_availability_set_name" {
  value       = azurerm_availability_set.windows_availability_set.name
}
output "windows_vm_name" {
  value       = [for vm in azurerm_windows_virtual_machine.windows_vm : vm.name]
}
output "windows_vm_dns_labels" {
  value       = [for vm in azurerm_windows_virtual_machine.windows_vm : azurerm_public_ip.windows_vm_public_ip_name[vm.name].domain_name_label]
}
output "windows_vm_private_ip_addresses" {
  value       = [for vm in azurerm_windows_virtual_machine.windows_vm : azurerm_network_interface.windows_nic[vm.name].private_ip_address]
}
output "windows_vm_public_ip_addresses" {
  value       = values(azurerm_public_ip.windows_vm_public_ip_name)[*].ip_address
}
