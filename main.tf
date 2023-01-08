terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test" {
  name     = "test-rg"
  location = "west Europe"
}

resource "azurerm_virtual_network" "test" {
  name                = "test-vnet"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_storage_account" "test" {
  name                     = "bujfycdxojoijhnbh"
  resource_group_name      = azurerm_resource_group.test.name
  location                 = azurerm_resource_group.test.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_subnet" "test" {
  name                 = "test-subnet"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "test2" {
  name                 = "test-subnet"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "test3" {
  name                 = "test-subnet"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "test" {
  name                = "test-nic"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  ip_configuration {
    name                          = "test-nic-ip-config"
    subnet_id                     = azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "test2" {
  name                = "test2-nic"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  ip_configuration {
    name                          = "test-nic-ip-config"
    subnet_id                     = azurerm_subnet.test2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "test3" {
  name                = "test3-nic"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  ip_configuration {
    name                          = "test-nic-ip-config"
    subnet_id                     = azurerm_subnet.test3.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_storage_container" "test" {
  name                  = "testcontainer"
  storage_account_name  = azurerm_storage_account.test.name
  container_access_type = "private"
}

resource "azurerm_virtual_machine" "test" {
  name                  = "test-vm"
  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  network_interface_ids = [azurerm_network_interface.test.id]
  vm_size               = "Standard_B1s"

  os_profile {
    computer_name  = "test"
    admin_username = "usertest"
    admin_password = "eWX68-/+pmchoehff"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_os_disk {
    name          = "disk"
    caching       = "ReadWrite"
    create_option = "FromImage"
    vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/disk.vhd"

  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine" "test2" {
  name                  = "test2-vm"
  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  network_interface_ids = [azurerm_network_interface.test2.id]
  vm_size               = "Standard_B1s"

  os_profile {
    computer_name  = "test2"
    admin_username = "usertest2"
    admin_password = "dcnSQ*/zcf44hmbzf"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_os_disk {
    name          = "disk2"
    caching       = "ReadWrite"
    create_option = "FromImage"
    vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/disk2.vhd"

  }
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine" "test3" {
  name                  = "test3-vm"
  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  network_interface_ids = [azurerm_network_interface.test3.id]
  vm_size               = "Standard_B1s"

  os_profile {
    computer_name  = "test3"
    admin_username = "usertest3"
    admin_password = "vhjkv545AZ+6ccxx"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_os_disk {
    name          = "disk3"
    caching       = "ReadWrite"
    create_option = "FromImage"
    vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/disk3.vhd"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}