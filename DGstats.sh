#!/bin/ksh

cat <<!
Basic statistics on standby database
!

typeset -u srvname
while [[ -z "$srvname" ]]
do
  read srvname?"Enter standby database unique name(q to quit) :"
  [[ $srvname = 'Q' ]] && exit
done

# get password for account sys for servername
usrpwd=$(/home/oracle/scripts/getpwd.sh $srvname SYSTEM)
cnx="SYSTEM/${usrpwd}@$srvname"

sqlplus -S $cnx <<!
set lines 200
column source_db_unique_name format a20 trunc
column name format a30 trunc
column value format a20 trunc
select source_db_unique_name
      ,name
      ,value
      ,time_computed
  from v\$dataguard_stats
 order by 1, 2
/
!

