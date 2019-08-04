#!/bin/ksh

cat <<!
Validates a database in details
!

typeset -u srvname
while [[ -z "$srvname" ]]
do
  read srvname?"Enter database unique name (q to quit) :"
  [[ $srvname = 'Q' ]] && exit
done

# get password for account SYS for service name
usrpwd=$(/home/oracle/scripts/getpwd.sh $srvname SYS)
cnxsys="SYS/${usrpwd}@$srvname"

dgmgrl <<!
connect $cnxsys
validate database verbose $srvname
!
