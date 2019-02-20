# BB.DD. PostgresSQL

## Comandos básicos

### Conexión a la BB.DD.

Lo primero, tenemos que mirar en qué agente se está ejecutando la BB.DD., conectarnos a el y luego conectarnos al contenedor en el que esté la corriendo el postgres.

Nos conectamos a la base de datos:  

~~~ bash
root@agent-f1-71:/# psql -Upostgres -h localhost -p 1025
psql (9.6.8)
SSL connection (protocol: TLSv1.2, cipher: ECDHE-RSA-AES256-GCM-SHA384, bits: 256, compression: off)
Type "help" for help.
~~~

Una vez aquí podemos ejecutar comandos de postgresSQL y de SQL.

* **\l**: Listar las bases de datos
* **\c _<dd.bb.>_**: Conectarse a la base de datos
* **set search_path to _database_**: Hacer consultas en una base de datoss concreta (una vez aquí, podemos usar los comandos estándar de SQL)
* **\dt** Listar las tablas de la base de datos actual
* **\d _tabla_**: descripción de laos camos de la tabla (_\dt+ tabla_ devuelve más informaciónd)
* **\q**: salir del postgres

## Operativas en la plataforma

Todas las BB.DD. son PostgresSQL y tienen un scheduler y tres servidores 1 master (pg0001), 1 síncrono (pg0002) que tiene la BD sincronizada con el máster, y un asíncrono (pg0003).

Para ver la base de datos a la que nos tenemos que conectar primero tenemos que ver a qué componente nos vamos a conectar (pgsandbox, pgmeme, pgprocess, ...). Normalmente nos conectaremos al **pg0001**.

Nos vamos al DC/OS correspondiente y buscamos el servicio concreto, y vemos en qué máquina se está ejecutando:
!(./DCOS_bbdd.png)

Abrimos un terminal, nos conectamos a la máquina y lugo al contendor de la base de datos:

~~~ bash
[root@agent-29 WORK01 ~]# docker ps
CONTAINER ID        IMAGE                                                                                         COMMAND                  CREATED             STATUS              PORTS               NAMES
11189b80b083        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/stratio/postgresql-community:1.1.2   "/docker-entrypoint.s"   7 days ago          Up 7 days                               mesos-3b70088e-c349-46aa-8def-41a845347e85-S15.dbd74146-cfd1-4db6-b7d6-b974f30c0073
0404d21a44dd        quay.io/calico/node:v1.1.3                                                                    "start_runit"            8 days ago          Up 8 days                               calico-node
[root@agent-29 WORK01 ~]# docker exec -ti 11189 /bin/bash
root@agent-29:/# 
~~~

Ahora ya nos podemos conectar al postgres.

~~~ bash
    root@agent-29:/# psql -Upostgres  -p 1025 
    psql (9.6.8)
    Type "help" for help
    postgres-# \l
                                  List of databases
    Name    |   Owner    | Encoding |   Collate   |    Ctype    |   Access privileges   
    -----------+------------+----------+-------------+-------------+-----------------------
    pgprocess | automation | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
    postgres  | postgres   | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
    template0 | postgres   | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
          |            |          |             |             | postgres=CTc/postgres
    template1 | postgres   | UTF8     | en_US.UTF-8 | en_US.UTF-8 | postgres=CTc/postgres+
          |            |          |             |             | =c/postgres
    (4 rows)
~~~

Usar una base de datos:

~~~ bash
    postgres-# \c pgprocess
    You are now connected to database "pgprocess" as user "postgres"
    pgprocess-# \dn
          List of schemas
          Name      |   Owner    
    ----------------+------------
    automationapi  | automation
    automationapi2 | automation
    public         | postgres
    (3 rows)
    pgprocess=# set search_path to automationapi;
    SET
    pgprocess=# \dt
                            List of relations
    Schema     |            Name            | Type  |   Owner    
    ---------------+----------------------------+-------+------------
    automationapi | complex_job                | table | automation
    automationapi | complex_job_runs           | table | automation
    automationapi | config_size                | table | automation
    automationapi | configurations             | table | automation
    automationapi | execution_request          | table | automation
    automationapi | groups                     | table | automation
    automationapi | job_type                   | table | automation
    automationapi | namespaces                 | table | automation
    automationapi | simple_job                 | table | automation
    automationapi | simple_job_runs            | table | automation
    automationapi | simplej_4_complexj         | table | automation
    automationapi | simplejruns_4_complexjruns | table | automation
    automationapi | stop_request               | table | automation
    automationapi | test                       | table | postgres
    (14 rows)
~~~
Ahora mos las cosillas que queramos.

## pgshared en estado inconsistente en Form01

Nos hemos encontrado con que el pgshared está como master pg-0002 y los otros dos están mal.

~~~ bash
[cloud-user@bootstrap-1 FORM01 ~]$ ssh 192.168.192.127
The authenticity of host '192.168.192.127 (192.168.192.127)' can't be established.
ECDSA key fingerprint is ce:85:0e:f7:6e:e2:3b:f3:cc:5b:23:fb:55:5f:a1:c9.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.192.127' (ECDSA) to the list of known hosts.
Last login: Fri Jan 11 10:20:19 2019 from 192.168.102.31
[cloud-user@agent-94 FORM01 ~]$ curl 192.168.192.49:10113/v1/service/status
{"status":[{"id":"pg-0002","role":"master","status":"RUNNING","dnsHostname":"pg-0002.pgshared.mss.form01.daas.gl.igrupobbva","assignedHost":"192.168.192.128","assignedZone":"TC-I-3","ports":[1025]},{"id":"DISCARDED-pg-0001","role":"sync_slave","status":"DISCARDED","dnsHostname":"DISCARDED-pg-0001.pgshared.mss.form01.daas.gl.igrupobbva","assignedHost":"192.168.192.104","assignedZone":"TC-I-2","ports":[1025]},{"id":"DISCARDED-pg-0001","role":"async_slave","status":"DISCARDED","dnsHostname":"DISCARDED-pg-0001.pgshared.mss.form01.daas.gl.igrupobbva","assignedHost":"192.168.192.98","assignedZone":"TC-I-2","ports":[1025]}]}[cloud-user@agent-94 FORM01 ~]$ curl 192.168.192.49:10113/v1/service/status|jq
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   625    0   625    0     0  99569      0 --:--:-- --:--:-- --:--:--  101k
{
  "status": [
    {
      "id": "pg-0002",
      "role": "master",
      "status": "RUNNING",
      "dnsHostname": "pg-0002.pgshared.mss.form01.daas.gl.igrupobbva",
      "assignedHost": "192.168.192.128",
      "assignedZone": "TC-I-3",
      "ports": [
        1025
      ]
    },
    {
      "id": "DISCARDED-pg-0001",
      "role": "sync_slave",
      "status": "DISCARDED",
      "dnsHostname": "DISCARDED-pg-0001.pgshared.mss.form01.daas.gl.igrupobbva",
      "assignedHost": "192.168.192.104",
      "assignedZone": "TC-I-2",
      "ports": [
        1025
      ]
    },
    {
      "id": "DISCARDED-pg-0001",
      "role": "async_slave",
      "status": "DISCARDED",
      "dnsHostname": "DISCARDED-pg-0001.pgshared.mss.form01.daas.gl.igrupobbva",
      "assignedHost": "192.168.192.98",
      "assignedZone": "TC-I-2",
      "ports": [
        1025
      ]
    }
  ]
}
~~~

Hago Backup de la BB.DD. pgshared (desde el pg-0002), entrando en el contenedor: 

~~~ bash
# pg_dumpall -U postgres -h localhost -p 1025 > pgshared_form_20190117```
# docker cp <id_cont>:pgshared_form_20190117 .
# mv pgshared_form_20190117 /home/cloud-user
# chown cloud-user /home/cloud-user/pgshared_form_20190117
~~~

Lo hago desde el propio pg-0002 que es el master:

Primero hago un clean para quitar los discarded:
~~~ bash
[root@agent-94 FORM01 ~]# curl -XPOST 192.168.192.49:10113/v1/service/clean
{"code":200,"component":"Framew192.168.192.49:10113/v1/service/status^C
[root@agent-94 FORM01 ~]# curl 192.168.192.49:10113/v1/service/status|jq
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   199    0   199    0     0  26815      0 --:--:-- --:--:-- --:--:-- 33166
{
  "status": [
    {
      "id": "pg-0002",
      "role": "master",
      "status": "RUNNING",
      "dnsHostname": "pg-0002.pgshared.mss.form01.daas.gl.igrupobbva",
      "assignedHost": "192.168.192.128",
      "assignedZone": "TC-I-3",
      "ports": [
        1025
      ]
    }
  ]
}
~~~

Como tenemos el pg-0002 como máster, nos tenemos que meter al exhibitor para que cambie a pg-0001.... 
para eso, abrimos el exhibitor: nos vamos al pg-0002, abrimos el descriptor y cambiamos su nombre de pg-0002 a pg-0001

Después de esto, en DCOS, nos aparecerá como pg-0001 y tendremos que parar todos menos el pg que tenga la ip del pg-0002 antigüo y luego ir añadiendo el sincrono y el asíncrono


