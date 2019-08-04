#!/bin/ksh

print 'Known environments are (defined in /etc/oratab)'
grep '/u01/app/oracle' /etc/oratab | sed -e 's/:.*//g'

