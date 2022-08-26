terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0"
    }
  }
}
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}
terraform {
  backend "azurerm" {
    resource_group_name  = "Backend-State"
    storage_account_name = "backendtf"
    container_name       = "tfbackend"
    key                  = "k8s_cluster.tfstate"
  }
}