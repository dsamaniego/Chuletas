# Operaciones en la base de datos.

Todas las BB.DD. son PostgresSQL y tienen un scheduler y tres servidores 1 master (pg0001), 1 síncrono (pg0002) que tiene la BD sincronizada con el máster, y un asíncrono (pg0003).

Para ver la base de datos a la que nos tenemos que conectar primero tenemos que ver a qué componente nos vamos a conectar (pgsandbox, pgmeme, pgprocess, ...). Normalmente nos conectaremos al **pg0001**.

Nos vamos al DC/OS correspondiente y buscamos el servicio concreto, y vemos en qué máquina se está ejecutando:
!(./DCOS_bbdd.png)

Abrimos un terminal, nos conectamos a la máquina y lugo al contendor de la base de datos:
```
[root@agent-29 WORK01 ~]# docker ps
CONTAINER ID        IMAGE                                                                                         COMMAND                  CREATED             STATUS              PORTS               NAMES
11189b80b083        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/stratio/postgresql-community:1.1.2   "/docker-entrypoint.s"   7 days ago          Up 7 days                               mesos-3b70088e-c349-46aa-8def-41a845347e85-S15.dbd74146-cfd1-4db6-b7d6-b974f30c0073
0404d21a44dd        quay.io/calico/node:v1.1.3                                                                    "start_runit"            8 days ago          Up 8 days                               calico-node
[root@agent-29 WORK01 ~]# docker exec -ti 11189 /bin/bash
root@agent-29:/# 
```
Ahora ya nos podemos conectar al postgres.
```
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
```
Usar una base de datos:
```
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
```
Ahora mos las cosillas que queramos.