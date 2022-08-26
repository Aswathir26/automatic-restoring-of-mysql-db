resource "azurerm_resource_group" "default" {
  name     = "RG_mysql"
  location = "westus2"
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#-"
  min_lower        = 1
  min_upper        = 1
}

output "password" {
  value     = random_password.password.result
  sensitive = true
}

resource "azurerm_mysql_flexible_server" "test" {
  name                   = var.server_name
  resource_group_name    = data.azurerm_resource_group.default.name
  location               = var.location
  administrator_login    = var.user_name
  administrator_password = random_password.password.result
  sku_name               = "B_Standard_B1s"
  version                = "5.7"
  zone                   = "1"
}

resource "azurerm_mysql_flexible_server_firewall_rule" "allow_will" {
  name                = var.firewall_name
  resource_group_name = data.azurerm_resource_group.default.name
  server_name         = azurerm_mysql_flexible_server.test.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_mysql_flexible_database" "database" {

  for_each = var.restore_database == true ? toset(var.database_name): toset([])
  name     = each.key

  resource_group_name = data.azurerm_resource_group.default.name
  server_name         = azurerm_mysql_flexible_server.test.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"

}

resource "null_resource" "dbtest" {
  for_each = toset(var.database_name)
  provisioner "local-exec" {

    command = <<-EOT
     mysql -h ${azurerm_mysql_flexible_server.test.name}.mysql.database.azure.com -u ${azurerm_mysql_flexible_server.test.administrator_login} -p${random_password.password.result} ${each.key} < ./dbs/${each.key}.sql
    
    EOT
  }
}