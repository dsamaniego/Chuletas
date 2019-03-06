# Minuteman

## Para chequearlo:  
`touch /environment/.inventory_cache && ansible -m shell -a 'curl -k https://soyuz.marathon.l4lb.thisdcos.directory/v1/ping' dcos_agent_private`
    Asi vemos si está funcionando bien.

Con los de Stratio hemos visto que parece que el funcionamiento de Minuteman se va degradando y hay que meterle un cate.

A lo bestia desde el contenedor de ilúvatar:  
`touch /environment/.inventory_cache && ansible -m shell -b -a 'systemctl restart dcos-minuteman' 'dcos_agent_private,dcos_agent_public,dcos_master'`

Hay un playbook de ansible (by Oscar):
[https://github.com/DatioBD/iluvatar/blob/devel/deployer/ansible/operations/reactive/restart_dcos_minuteman.yml]

He revisado el playbook y hace lo siguiente:
1. chequea que esté definido el "host"
2. para el dcos-minuteman
3. ve si está sincronizado el ntpd
4. Obtiene el servidor ntpd
5. Para NTP
6. Borra ipv6 de la configuración de NPT
7. Fuerza la sincronización de NTP (`ntpdat -s <ntp_server>`)
8. Inicia NTP
9. Arranca dcos-minuteman

Ahora bien, esto está en la rama "devel" de Iluvatar, por lo que no está desplegado.

Hay una alerta reactiva que reinicia el minuteman cuando está caido o no responde:

~~~ bash
[root@agent-2 PRIV02 cloud-user]# curl http://localhost:61421 -v
* Rebuilt URL to: http://localhost:61421/
*   Trying 127.0.0.1...
* Connected to localhost (127.0.0.1) port 61421 (#0)
> GET / HTTP/1.1
> Host: localhost:61421
> User-Agent: curl/7.48.0
> Accept: */*
>
< HTTP/1.1 200 OK
< Vary: Accept
~~~

## Degradación de minuteman

Se está observando que minuteman se degrada, lo que trae como consecuencia que haya jobs que no vayan cuando se lanzan. 

Sospecha a confirmar, cuando se están levantando los agentes relacionados con la actualización de las AZs, minuteman no se reconfigura bien en esos agentes y empieza la degradación.

### Chequeo para el lunes

Hacer el chequeo de minuteman y ver si los agentes en los que falla pertenecen a la AZ3 que es la que se va a actualizar este fin de semana.

No ha fallado en ninguno, he probado por 4 veces en cada entorno de live el comando de ping.

#### Mas cosas

Discovery de FINA y minuteman.

En LIVE-GL falla discovery en la conexión a la BD, está mirando arquitectura.

han cambiado dos parámetros en el descritpro:
 "MB_DB_HOST": "master.pgsandbox.l4lb.live01.daas.gl.igrupobbva",
 "MB_DB_PORT": "5432",

Por: 
 "MB_DB_HOST": "pg-0001.pgsandbox.mss.live01.daas.gl.igrupobbva",
 "MB_DB_PORT": "1025"

 para recordarlo.