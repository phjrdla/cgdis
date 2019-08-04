#!/bin/ksh

typeset -u srvname
while [[ -z "$srvname" ]]
do
  read srvname?"Enter database unique name (q to quit) :"
  [[ $srvname = 'Q' ]] && exit
done

# get password for account system for srvname
usrpwd=$(/home/oracle/scripts/getpwd.sh $srvname SYSTEM)
cnx="SYSTEM/${usrpwd}"

sqlplus -S $cnx@$srvname <<!
set lines 200
column network_name format a30 trunc
select service_id, network_name, creation_date
from v\$active_services
where network_name is not null
order by network_name
/
!
