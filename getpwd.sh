#!/bin/ksh

(( $# != 2 )) && { print "usage is $0 envname usrname"; exit; }

typeset -u envname=$1
typeset -u usrname=$2

rec=$(grep "${envname},${usrname}," /home/oracle/scripts/etc/.credentials)

# returns passwd
print ${rec##*,}

