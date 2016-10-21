#!/bin/bash

export ASPNETCORE_ENVIRONMENT="Development"
export BangazonWeb_Db_Path="PATH/TO/DATABASE.DB"
if [[ $# -eq 0 ]]; then
  echo -e "$(tput bold)██████╗  █████╗ ███╗   ██╗ ██████╗  █████╗ ███████╗ ██████╗ ███╗   ██╗
██╔══██╗██╔══██╗████╗  ██║██╔════╝ ██╔══██╗╚══███╔╝██╔═══██╗████╗  ██║
██████╔╝███████║██╔██╗ ██║██║  ███╗███████║  ███╔╝ ██║   ██║██╔██╗ ██║
██╔══██╗██╔══██║██║╚██╗██║██║   ██║██╔══██║ ███╔╝  ██║   ██║██║╚██╗██║
██████╔╝██║  ██║██║ ╚████║╚██████╔╝██║  ██║███████╗╚██████╔╝██║ ╚████║
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝
                                                                      $(tput sgr0)"
  echo -e "Bangazon CLI. Use $(tput bold)bangazon run$(tput sgr0) to run, $(tput bold)bangazon migration$(tput sgr0) if database migrations need to take place, or $(tput bold)bangazon restore$(tput sgr0) to restore dependencies."
  exit 1
elif [ "$1" == "run" ]; then
  open -a 'Google Chrome' 'http://localhost:5000'
  dotnet run
elif [ "$1" == "restore" ]; then
  dotnet restore
  dotnet ef database update
  bower install
  open -a 'Google Chrome' 'http://localhost:5000'
  dotnet run
elif [ "$1" == "migration" ]; then
  rm bangazon.db
  rm -rf /Migrations
  dotnet ef migrations add Initial
  dotnet ef database update
  dotnet restore
  bower install
  open -a 'Google Chrome' 'http://localhost:5000'
  dotnet run
else echo "An error occured."
fi
