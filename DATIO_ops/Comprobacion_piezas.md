# Comprobación de servicios.

## Sherlock
Desde un agente:
~~~ bash
export SHERLOCK_USER=<usuario_DCOS> 
export SHERLOCK_PASS=<password_DCOS>th
TOKEN=$(curl -s -k https://sherlock.maraon.l4lb.$(dnsdomainname)/v1/dcos/token -X POST -d '{"username": "'$SHERLOCK_USER'", "password": "'$SHERLOCK_PASS'" }' -H 'Content-Type: application/json')
curl -k -f -H "Authorization:token=$TOKEN" https://admin.$(dnsdomainname):8443/service/metronome/ping
~~~
ó
~~~
curl -k https://sherlock.marathon.l4lb.$(dnsdomainname)/v1/gosecsso/token -X POST -d '{"username": "<DCOS_user>", "password": "<DCOS_password>" }' -H 'Content-Type: application/json'
~~~

## Consulta Postgress.

En cualquier postgress (pgmeme, pgsandbox, pgprogress), tenemos un scheduler y 3 instancias, 1 master (pg-0001), 1 síncrona con el master (pg-0002) y 1 asíncrona (pg-0003)
Para consultar es estado del servicio, hay que sacar la ip y el puerto del scheduler y hacer la siguiente consulta:
`# curl -v <IP>:<PUERTO>/v1/services/status |jq`

Esto nos dirá cómo están los pg's

