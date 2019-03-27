# CURLS varios.

## Subir a Nexus

~~~bash
curl -k -v -u <user>:<pass> --upload-file <fichero> https://nexus.daas.work.es.ether.igrupobbva/repository/<ruta>/<fichero>
~~~

## Desplegar con soyuz

Necesitamos la password del usuario _oper_

### Componente

~~~bash
curl -u oper -H 'content-type: application/json' --data-binary "@component*.json" -X POST "https://soyuz.marathon.l4lb.$(dnsdomainname)/v1/components" 
~~~

### Despliegue

~~~bash
curl -u oper -H 'content-type: application/json' -X POST --data-binary "@deploy*.json" "https://soyuz.marathon.l4lb.$(dnsdomainname)/v1/deployments" 
~~~

## Chequeo de Sherlock

~~~bash
curl https://sherlock.marathon.l4lb.$(dnsdomainname)/v1/dcos/token -H 'Content-Type: application/json' -d '{"username": "$USER","password": "$PASSW"}'
~~~

## Consultas de Vault

Estado de sellado de vault (desde uno de los gosec):
~~~bash
 curl -k https://localhost:8200/v1/sys/seal-status
 ~~~

 
