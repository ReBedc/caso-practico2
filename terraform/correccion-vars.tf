variable "location" {
  type = string
  description = "Región de Azure donde crearemos la infraestructura"
  default = "uksouth" 
}

variable "storage_account" {
  type = string
  description = "Nombre para la storage account"
  default = "cp2unir072022"
}

variable "public_key_path" {
  type = string
  description = "Ruta para la clave pública de acceso a las instancias"
  default = "~/.ssh/id_rsa.pub" 
}


variable "ssh_user" {
  type = string
  description = "Usuario para hacer ssh"
  default = "azureuser"
}

# ---- variables utilizadas en la practica ----
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
# Los nombres de las maquinas virtuales se estableceran segun la posición del array "vms" de forma que
# en la posicion 0 se definira el nombre para la maquina master, en la posicion 1 el nombre para la maquina
# worker y en la posicion 2 en nombre para la maquina nfs
variable "vms" {
  description = "Maquinas virtuales"
  type        = list(string)
  default     = ["master", "worker", "nfs"]
}
# Los tamaños de las maquinas virtuales se estableceran segun la posición del array "sizes" de forma que
# en la posicion 0 se definira el tipo de la maquina master, en la posicion 1 el el tipo de la maquina
# worker y en la posicion 2 el tipo de la maquina nfs
variable "sizes" {
  description = "Tipos de las maquinas virtuales"
  type        = list(string)
  default     = ["Standard_D2_v2", "Standard_A2_v2", "Standard_A2_v2"]
  
}