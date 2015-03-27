#!/bin/bash
echo "Connect with user oracle"
sudo su -l oracle

echo 'Import environment variables'
export ORACLE_SID=tests
export ORACLE_BASE=/u01/app/oracle 
export ORACLE_HOME=/u01/app/oracle/product/11.2/dbhome_1 
export PATH=$PATH:$ORACLE_HOME/bin 
  
echo 'Create database Tests'
if [ ! -d /u01/app/oracle/oradata/tests ] ; then
	 su -c "dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbName tests -sysPassword 0r4c13b0x -systemPassword 0r4c13b0x -scriptDest /u01/app/oracle/oradata/tests -characterSet WE8ISO8859P1" -s /bin/sh oracle
fi

echo 'Start listener'
su -c "lsnrctl start" -s /bin/sh oracle

echo 'Startup database'
su -c "sqlplus /nolog <<EOF
	conn 0r4c13b0x/sys as sysdba
	shutdown immediate;
	startup
	exit
EOF" -s /bin/sh oracle