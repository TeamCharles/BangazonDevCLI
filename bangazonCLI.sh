#!/bin/bash
database=$(head -n 1 ../BangazonDevCLI/FILE_LOCATIONS)
if [[ "$database" == "" ]]; then
  echo -e "🚀  First time Bangazon Developer CLI setup\n"
  echo -e "Please enter the $(tput bold)full path of bangazon.db$(tput sgr0):"
  read database
  while [[ "$database" == "" ]]; do
    echo -e "$(tput bold)$(tput setaf 1)ERROR! Enter a valid file path:$(tput sgr0) "
    read database
  done
  echo $database >> ../BangazonDevCLI/FILE_LOCATIONS
fi
export ASPNETCORE_ENVIRONMENT="Development"
export BangazonWeb_Db_Path=$database
if [[ $# -eq 0 ]]; then
  echo -e "\n$(tput bold)██████╗  █████╗ ███╗   ██╗ ██████╗  █████╗ ███████╗ ██████╗ ███╗   ██╗
██╔══██╗██╔══██╗████╗  ██║██╔════╝ ██╔══██╗╚══███╔╝██╔═══██╗████╗  ██║
██████╔╝███████║██╔██╗ ██║██║  ███╗███████║  ███╔╝ ██║   ██║██╔██╗ ██║
██╔══██╗██╔══██║██║╚██╗██║██║   ██║██╔══██║ ███╔╝  ██║   ██║██║╚██╗██║
██████╔╝██║  ██║██║ ╚████║╚██████╔╝██║  ██║███████╗╚██████╔╝██║ ╚████║
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝
                                                                      $(tput sgr0)"
  echo -e "Current database location: $(tput setaf 5)$database$(tput sgr0)\n
    $(tput bold)bangazon run$(tput sgr0)\t Run the project\n
    $(tput bold)bangazon migration$(tput sgr0)\t Update the database with new migrations\n
    $(tput bold)bangazon restore$(tput sgr0)\t Restore .NET Core and front-end dependencies\n
    $(tput bold)bangazon reset$(tput sgr0)\t Change the location of your database"
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
  rm $database
  rm -rf /Migrations
  dotnet ef migrations add Initial
  dotnet ef database update
  dotnet restore
  bower install
  open -a 'Google Chrome' 'http://localhost:5000'
  dotnet run
elif [ "$1" == "reset" ]; then
  rm $database
  rm ../BangazonDevCLI/FILE_LOCATIONS
  echo -e "Enter the new $(tput bold)full path of bangazon.db$(tput sgr0):"
  read database
  while [[ "$database" == "" ]]; do
    echo -e "$(tput bold)$(tput setaf 1)ERROR! Enter a valid file path:$(tput sgr0) "
    read database
  done
  echo $database >> ../BangazonDevCLI/FILE_LOCATIONS
  echo -e "New database location: $(tput setaf 5)$database$(tput sgr0)"
else echo "An error occured."
fi
