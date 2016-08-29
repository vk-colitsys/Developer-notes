Steps for installing devnotes

1) Unzip files to desired directory on webserver
2) Run included sql file on your SQL server to create database/tables (either MSSQL or mySQL)
3) Create datasource on your coldfusion server, name it whatever you want, point it to your newly created database
4) Change datasource in line 2 of index.cfm to whatever you named it.
4) Enjoy!