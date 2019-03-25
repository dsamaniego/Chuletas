# Alertas.
Para poder tratar las alertas, el usuario nominal XE tiene que estár en el grupo de monitoriong correspondiente:
* LIVE_ES: DASP_US_OPKDIT, DAESL_US_MNTEST
* LIVE_GL: DAGP_US_OPKDIT
* WORK_ES: DASD_US_OPKDIT, DASD_US_MNKDIT
* WORK_GL: DAGD_US_OPKDIT, DAGD_US_MNFDEV

Los permisos de work ya están asignados, pero los de LIVE me los tengo que asignar cada día.

Tengo el repositorio en /home/jhicar/Repos/argos
Las condiciones para que salten las alertas en **monitoring-kibana-1**, carpeta `/usr/share/elastalert/real_rules/`

## hdfsclient sin espacio en /
Revisar los `/home` de los usuarios que suelen dejar ficheros grandes en sus directorios de trabajo. En teoría, estos directorios serían para que dejasen ahí cosas que van a usar en sus ingestas, pero que tienen que pasar al Isilon, y sólo deberían estar ahí temporalmente.

Lo mismo sería una buena idea tener un job que hiciese un barrido de esos directorios y hacer limpieza.

Hablarlo con Iago, en principio, todo lo que exceda de 3M no debe de estar en /home mas de 15 días.

## No hay espacio para las persisencias.
En cada entorno hay definido un espacio que tienen que usar los contenedores para dejar sus datos: está en /storage, es común a todos los agentes porque un docker cae en un contenedor y luego puede caer en otro distinto.

Para ver las persistencias usaremos el siguiente comando:
```
curl http://leader.mesos:5050/slaves| jq '.slaves[] | select(.hostname == "ip") '
```
Donde la ip será la del agente que está ejecutando el proceso.¿?
Nos va a devolver algo del estilo:
```
<aquí metemos el json que devuevle.>
```
## Chequeos en tiempo real.

En todos los entornos hay una serie de ficheros que guardan el estado de ciertas cosas. Está en `/opt/monitoring/.tmp` podemos hacer un cat de los diferentes ficheros _*status_ para ver el estado del chequeo.

### Optimus backpressure

Consultar: [root@monitoring-kibana-1 LIVE01 .tmp]# cat /opt/monitoring/.tmp/optimus_backpreassure_status 
list_pending: [0, 0, 0]
list_running: [0, 0, 0]

Contrastarlo con lo que devuelve el curl

Nos tenemos que conectar a pgprocessing:

~~~bash
root@agent-29:/# psql -Upostgres -p 1025 
psql (9.6.8)
Type "help" for help.
postgres=# \c pgprocess
You are now connected to database "pgprocess" as user "postgres".
pgprocess=# \dn
       List of schemas
      Name      |   Owner    
----------------+------------
 automationapi  | automation
 automationapi2 | automation
 public         | postgres
(3 rows)

pgprocess=# SET search_path to automationapi;
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

pgprocess=# Select uuid, job_name from simple_job_runs where status='RUNNING' OR status='STARTING';
                 uuid                 |                 job_name                 
--------------------------------------+------------------------------------------
 6f1e42ca-03f8-42f1-887c-49c75c18a68c | kdit-dev.processing.job-monitoring-spark
(1 row)

pgprocess=# Select count(*) from simple_job_runs where status='PENDING';
 count 
-------
   328
(1 row)

pgprocess=# Select count(*) from simple_job_runs where status='RUNNING' OR status='STARTING';      
 count 
-------
     1
(1 row)

Esto es lo mismo que estamos obteniendo con el cat en monitorin-kibana-1.

pgprocess=# Select * from simple_job_runs where status='RUNNING' OR status='STARTING';
                 uuid                 |                 job_name                 |  metronome_run_id   | status  | tasks  |       created_at        | completed_date | created_by |       updated_at        
--------------------------------------+------------------------------------------+---------------------+---------+--------+-------------------------+----------------+------------+-------------------------
 6f1e42ca-03f8-42f1-887c-49c75c18a68c | kdit-dev.processing.job-monitoring-spark | 201812140804185zZOd | RUNNING | List() | 2018-12-14 08:04:13.065 |                |            | 2018-12-14 08:04:18.148
(1 row)

Este job no lo encontramos en Marathon, con lo que parece que parece que ha habido algń problema y este job ha desaparecido pero no en la bd.

Limpiamos el job: 

pgprocess=# select count(*) from execution_request where status='PENDING';
 count 
-------
   323
(1 row)

pgprocess=# update simple_job_runs set status='FAILURE' where uuid='6f1e42ca-03f8-42f1-887c-49c75c18a68c';
UPDATE 1
~~~

Reiniciamos Optimus y empiezan a salir los jobs.

## Canarios.
Para chequear las piezas de plataforma, hay servicios para cada pieza que chequean periódicamente, cuando haya alertas de alguna pieza de plataforma, miramos en el DCOS los logs del canario (se llaman _mon<nombre_pieza>_). Para ver el chequeo que ha fallado y poder tirar del hilo.

## Alertas reactivas.
Hay ciertas alertas que lanzan automáticamente jobs para arreglar el problema que ha levantado la alerta.

Los jobs se ejecutan en Jenkins, y el job en concreto al que se invoca es **Ops --> ops_iluvatar**, en el histórico podemos ver lo que se ha lanzado.

# Serlock
Es el que se encarga de la interacción con todo el login del SSO de todas las piezas... se comunica con **GOSECsso**, así que la alerta que salte seguramente vendrá de que se ha caído el GOSECsso.

## Falsas alarmas.
bootstrap-X_external_services_dnsbased_ha --> dnsbased-ha is down. --> Bug de monitoring, ya está arreglado en work pero no en live.
agent-f1-182 --> Fallo de monitoring, no hacer caso.

## Documentación
* [Sherlock operation](https://datiobd.atlassian.net/wiki/spaces/MON/pages/1026293793/sherlock+operation?focusedCommentId=1049886724#comment-1049886724)
* [Sherlogk erores](https://datiobd.atlassian.net/wiki/spaces/CPPR/pages/653525087/Sherlock+Errores)
No están hablilitados estos servicios en esta máquina.


