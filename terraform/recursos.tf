
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "vnic-${count.index}"
  count               = length(var.vms)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconf-${count.index}"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.${count.index + 10}"
    public_ip_address_id          = azurerm_public_ip.myPublicIp.*.id[count.index]
  }
}

resource "azurerm_public_ip" "myPublicIp" {
  count               = length(var.vms)
  name                = "vmip-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = length(var.vms)
  name                = "vm-${var.vms[count.index]}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "${var.sizes[count.index]}"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  plan {
    name      = "centos-8-stream-free"
    product   = "centos-8-stream-free"
    publisher = "cognosys"
  }


  source_image_reference {
    publisher = "cognosys"
    offer     = "centos-8-stream-free"
    sku       = "centos-8-stream-free"
    version   = "22.03.28"
  }
}


