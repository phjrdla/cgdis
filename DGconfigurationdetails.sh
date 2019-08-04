#!/bin/ksh

cat <<!
Shows Data Guard configuration Details
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

# get password for account SYS for service name
usrpwd=$(/home/oracle/scripts/getpwd.sh $srvname SYS)
cnxsys="SYS/${usrpwd}@$srvname"

dgmgrl <<!
connect $cnxsys
show configuration verbose
!
