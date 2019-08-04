#!/bin/ksh

cat <<!
Returns Data Guard basic properties
!

typeset -u srvname
if (( $# == 1 ))
then
  srvname=$1
else
  while [[ -z "$srvname" ]]
  do
    read srvname?"Enter database unique name (q to quit) :"
    [[ $srvname = 'Q' ]] && exit
  done
fi

# get password for account sys for srvname
usrpwd=$(/home/oracle/scripts/getpwd.sh $srvname SYSTEM)
cnx="SYSTEM/${usrpwd}@$srvname"

sqlplus -S $cnx <<!
set lines 200
SELECT *
FROM V\$DATAGUARD_CONFIG
/
!

