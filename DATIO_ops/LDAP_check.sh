#!/usr/bin/env bash

TOTAL=0

for i in {1..100}
do

START_TIME=$SECONDS

### LIVE-ES
#OUTPUT=$(ldapsearch -o ldif-wrap=no -ZZ -x -D "cn=jenkins,cn=GlobalWrite,cn=Administrators,cn=Global,dc=bbva,dc=com" -w h7gd5s782F7YpQrd07mTZF0G2O3VhDBPi27ncR4WTw8BECbUE3kRwh7f5d4d341a -h ldap.secaas.live.es.ether.igrupobbva -p 389 -LLL dn -b "dc=bbva,dc=com" "(&(objectClass=posixAccount)(cn=XE62063))" )

### LIVE-MX
OUTPUT=$(ldapsearch -x  -ZZ -D "cn=iluvatar,cn=WriteAdmins,cn=Administrators,cn=LIVE01,cn=Tenant,c=MX,dc=bbva,dc=com" -w "eihais7Eichohk7Ineegaideebaida6iequ0jue5Naex2tahsh1eeyeu1ohthahc" -h ldap.secaas.live.mx.ether.igrupobbva  -p 389 -LLL dn -b 'ou=ServiceGroups,cn=LIVE01,cn=Tenant,c=MX,dc=bbva,dc=com')

ELAPSED_TIME=$(($SECONDS - $START_TIME))

if [ $ELAPSED_TIME -ge 3 ] ; then
echo "$i"
date +"%H:%M"
echo "La muestra $i ha tardado $ELAPSED_TIME segundos"
TOTAL=$(($TOTAL + 1))
echo "Total: $TOTAL de $i peticiones"
echo ""
fi

sleep 1

done
