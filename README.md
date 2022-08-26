# Restoring of mysql databases

To restore mysql databases in kubernetes, which is backuped and saved in dbs directory follow the below given steps



**Step 1:**

git clone https://github.com/Aswathir26/automatic-restoring-of-mysql-db.git

**Step 2:**

save your backup of databases in dbs directory (eg: db_backup1 and db_backup2) and specify that names in variable.tf (for variable database_name)

**Step 3:**

run the commands:

 $ terraform init
 $ terraform plan
 $ terraform apply