#!/bin/bash


if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  echo "Usage: `basename $0` DATABASE_NAME    NAME_OF_DUMP_DB"
  exit 0
fi

if [ -f "$PWD/$2" ] && [[ $2 =~ \.pgsql$ ]] 
then
    check=`systemctl status postgresql | grep active | awk '{print $2}'`     
    
    if [ $check = "active" ];then

        sudo -u postgres createdb $1'_db';
        sudo -u postgres  psql -c "CREATE USER $1  WITH PASSWORD '$(printf '%s' "12345678")';"   
        sudo -u postgres  psql -c "GRANT ALL PRIVILEGES ON DATABASE $1_db to $1";
        sudo -u postgres  psql -c "ALTER ROLE $1 WITH SUPERUSER";
        sudo -u postgres  psql -c "ALTER ROLE $1 WITH CREATEROLE";
        sudo -u postgres  psql -c "ALTER ROLE $1 WITH CREATEDB";
        sudo -u postgres  psql -c "ALTER ROLE $1 WITH REPLICATION";
        sudo -u postgres  psql -c "ALTER ROLE $1 WITH BYPASSRLS";
        sudo -u postgres  psql  $1_db < $PWD/$2 
    else
        echo "Start you postgresql service!!"
    fi
else
   echo "please run the script where you put your database dump file or check your file extention."
fi
