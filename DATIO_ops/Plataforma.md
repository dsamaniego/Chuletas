# Funcinamiento de la plataforma

## Metronome

Coordina la ejecución de los jobs.
Está arrancado en los nodos master.

## Minuteman

Actua como balanceador y DNS distribuido. Es otro DNS, ya que hay uno también en los bootstrap.

Cualquier petición que venga a través de l4lb (**Layer 4 Load Balancer**) resuelve minuteman.

**dcos-minuteman** es un servicio que está corriendo en todos los nodos.
Para chequearlo:  
`touch /environment/.inventory_cache && ansible -m shell -a 'curl -k https://soyuz.marathon.l4lb.thisdcos.directory/v1/ping' dcos_agent_private`
    Asi vemos si está funcionando bien.

Con los de Stratio hemos visto que parece que el funcionamiento de Minuteman se va degradando y hay que meterle un cate.

A lo bestia desde el contenedor de ilúvatar:  
`touch /environment/.inventory_cache && ansible -m shell -b -a 'systemctl restart dcos-minuteman' 'dcos_agent_private,dcos_agent_public,dcos_master'`

Hay un playbook de ansible (by Oscar): [https://github.com/DatioBD/iluvatar/blob/devel/deployer/ansible/operations/reactive/restart_dcos_minuteman.yml]

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

## Kafka

Es un gestor de colas de mensajes.

### Links.

* [Documentación oficial Apache](https://kafka.apache.org/)
* [Documentación Stratio](https://stratio.atlassian.net/wiki/spaces/KAFKA2x2x/overview)
* Documentación de Arquitectura:
    * 
    * [Troubleshooting](https://datiobd.atlassian.net/wiki/spaces/TA/pages/830636114/Troubleshooting+-+Kafka)
    * [Capacity plan (doc. arquitectura)](https://docs.google.com/document/d/17ges-qPdEvR53Cra_V1nWKBg7eGaDOjc8jilRB3U0LA/edit?ts=5c6ac7ba#heading=h.8je8sdf7qlsm)
* 