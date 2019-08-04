#!/bin/ksh

# checks local listener status

lsnrctl status > /tmp/lsnrctlstatus.out
rc=$?

(( rc != 0 )) && { print 'Local listener is stopped'; exit; }

cat /tmp/lsnrctlstatus.out
