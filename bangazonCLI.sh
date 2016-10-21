#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "\n Welcome to the Bangazon setup wizard! \n"
  echo "What is the path to your database? (ex: PATH/TO/DATABASE.DB)"
  read path_db
  export BangazonWeb_Db_Path="$path_db"
  echo "\n"
  echo "Great! Your path is set to BangazonWeb_Db_Path=\"$path_db\""
  echo "\n"
  echo "Is this a development environment? (Y/N)"
  select yn in "Yes" "No"; do
    case $yn in
        Yes ) export ASPNETCORE_ENVIRONMENT="Development"; echo "Great!  Your environment was successful set as Development"; break;;
        No ) export ASPNETCORE_ENVIRONMENT="Production"; echo "Great!  Your environment was successful set as Production"; break;;
    esac
  done
  echo "\n"
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
  dotnet restore
  rm -rf /Migrations
  dotnet ef migrations add Initial
  dotnet ef database update
  bower install
  open -a 'Google Chrome' 'http://localhost:5000'
  dotnet run
else echo "An error occured."
fi
