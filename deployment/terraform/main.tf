# Configure the Azure provider
terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.116.0"
        }
    }
}

provider "azurerm" {
    features {}

    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
    name     = "${var.prefix}-rg"
    location = var.location
}

resource "azurerm_virtual_network" "vnet" {
    name                = "${var.prefix}-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
    name                 = "${var.prefix}-subnet"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
    name                = "${var.prefix}-nic"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "${var.prefix}-ip-conf"
        subnet_id                     = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.pip.id 
    }
}

resource "azurerm_public_ip" "pip" {
    name                = "${var.prefix}-public-ip"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method   = "Static"
}

resource "azurerm_linux_virtual_machine" "vm" {
    name                = "${var.prefix}-vm"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = "Standard_B2ms"
    admin_username      = "adminuser"
    
    network_interface_ids = [
        azurerm_network_interface.nic.id,
    ]

    admin_password = var.admin_password

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "${var.prefix}-vm"
    disable_password_authentication = false
    custom_data = filebase64("${path.module}/customData.tpl")
}

resource "azurerm_storage_account" "adls2" {
    name                     = replace("${var.prefix}-adls2","-","")
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
    account_kind             = "StorageV2"
    is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "adls2_fs" {
    name               = replace("${var.prefix}-adls2-fs","-","")
    storage_account_id = azurerm_storage_account.adls2.id
}
resource "azurerm_storage_data_lake_gen2_path" "adls2_fs_path" {
    path               = "kafka/landing"
    filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.adls2_fs.name
    storage_account_id = azurerm_storage_account.adls2.id
    resource           = "directory"
}