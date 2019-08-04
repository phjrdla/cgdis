#!/bin/ksh

cat <<!
Lists RMAN backups summary
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
usrpwd=$(/home/oracle/scripts/getpwd.sh $srvname SYS)
cnx="SYS/${usrpwd}@$srvname"

rman target $cnx <<!
list backup summary;
!

