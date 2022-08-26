variable "server_name" {
  type    = string
  default = "mysqldb-restore"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "user_name" {
  type    = string
  default = "mysqluserdb"
}

variable "firewall_name" {
  type    = string
  default = "mysql_firewall"
}


variable "database_name" {
  type    = list(string)
  default = ["db_backup1", "db_backup2"]
}

variable "restore_database"{
  type =bool
  default = false
}