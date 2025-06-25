terraform {
  required_version = "1.11.0"

  backend "azurerm" {
    resource_group_name  = "jenkins-tfstate-rg"
    storage_account_name = "jenkinstfstate1"
    container_name       = "tfstate"
    key                  = "jenkins.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.34.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "8888575e-1be3-4d16-8500-ee8a4a1b570c"
}


resource "azurerm_resource_group" "jen-1" {
  name     = "jenkins-rg"
  location = "East US"

}
resource "azurerm_resource_group" "jen-2" {
  name     = "jenkins-rg1"
  location = "West US"

}

resource "storage_account_name" "jen-stg" {
               depends_on = [ azurerm_resource_group.jen-1 ]
  name                     = "jenkinstfstate1"
  resource_group_name      = "jenkins-rg1"
  location                 = "westus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
