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

## Zookeeper-Sandbox (zk-sandbox)
Procedimiento para corregir la situación del ZK "zk-sandbox" de Live ES bajo similares condiciones.

El procedimiento a realizar es el siguiente:

1. Backup de plataforma del zk-sandbox
2. Incorporar los dos nodos (zk-0001 y zk-0003) al ensemble de ZK
    * zk-0001
        1. Acceder al agente privado 192.168.192.39
        2. Parar el docker asociado al zk-0001
        ~~~ bash
        $ sudo docker ps
        $ sudo docker rm -f <CONTAINER_ID>
        ~~~
    * zk-0003
        1. Acceder al agente privado 192.168.192.2
        2. Parar el docker asociado al zk-0003
        ~~~ bash
        $ sudo docker ps
        $ sudo docker rm -f <CONTAINER_ID>
        ~~~
3. Verificación reincorporación zknodes al ensemble
    - Acceso al zk-sandbox usando zkCli
    - **Comando a ejecutar**: `$ curl -v -X POST <IP Scheduler zk-sandbox>:<Puerto scheduler>/v1/service/status | jq`
    - **Resultado esperado**: El ensemble de ZK está formado por tres nodos (zk-0001, zk-0002 y zk-0003)
4. Corregir la zona de disponibilidad del nodo zk-0003
    1. Destruir el zknode zk-0003
        - **Comando a ejecutar**: `$ curl -v -X POST <IP Scheduler zk-sandbox>:<Puerto scheduler>/v1/service/teardown/zk-0003`
    2. Parar el Scheduler de zk-sandbox
    3. Modificar desde Marathon el descriptor de zk-sandbox corrigiendo el número de AZs
        - `env.FRAMEWORK_AVAILABILITY_ZONES_NUMBER = 3`
    4. Arrancar scheduler de zk-sandbox
    5. Añadir un nuevo zknode al ensemble
        - **Comando a ejecutar**: `$ curl -v -X POST <IP Scheduler zk-sandbox>:<Puerto scheduler>/v1/service/addnode`
5. Verificación zknodes en AZs diferentes
    - **Comando a ejecutar**: `$ curl -v -X POST <IP Scheduler zk-sandbox>:<Puerto scheduler>/v1/service/status`
    - **Resultado esperado**: Los tres nodos están en AZs diferentes.   
        