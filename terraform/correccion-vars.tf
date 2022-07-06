variable "resource_group_name" {
  default = "rg-createdbyTF"
}

variable "location_name" {
  default = "uksouth"
}

variable "network_name" {
  default = "vnet1"
}

variable "subnet_name" {
  default = "subnet1"
}

variable "vms" {
  description = "Maquinas virtuales"
  type        = list(string)
  default     = ["master", "worker", "nfs"]
}

variable "sizes" {
  description = "Tipos de las maquinas virtuales"
  type        = list(string)
  default     = ["Standard_D2_v2", "Standard_A2_v2", "Standard_A2_v2"]
}