#!/bin/bash


if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
   echo "It will create new database with _db with username." 
   echo "Usage: `basename $0` USER_NAME    NAME_OF_DUMP_DB" 
   echo "" 
   echo "Example: ./create_db.sh   mehedi   db_dump.pgsql" 
   echo "It will create user with name: mehedi and database name : mehedi_db" 
   exit 0 
fi

if [ -f "$PWD/$2" ] && [[ $2 =~ \.pgsql$ ]] 
then
    check=`systemctl status postgresql | grep active | awk '{print $2}'`     
    
    if [ $check = "active" ];then

        to_lower_string=$1;
        db_name=${to_lower_string,,}'_db';

        sudo -u postgres createdb ${db_name};
        sudo -u postgres  psql -c "CREATE USER $1  WITH PASSWORD '$(printf '%s' "12345678")';"   
        sudo -u postgres  psql -c "GRANT ALL PRIVILEGES ON DATABASE ${db_name} to $1";
        sudo -u postgres  psql -c "ALTER ROLE $1 WITH SUPERUSER";
        sudo -u postgres  psql -c "ALTER ROLE $1 WITH CREATEROLE";
        sudo -u postgres  psql -c "ALTER ROLE $1 WITH CREATEDB";
        sudo -u postgres  psql -c "ALTER ROLE $1 WITH REPLICATION";
        sudo -u postgres  psql -c "ALTER ROLE $1 WITH BYPASSRLS";
        sudo -u postgres  psql  ${db_name} < $PWD/$2;
    else
        echo "Start you postgresql service!!"
    fi
else
   echo "please run the script where you put your database dump file or check your file extention."
fi
