# Alertas.
Para poder tratar las alertas, el usuario nominal XE tiene que estár en el grupo de monitoriong correspondiente:
* LIVE_ES: DASP_US_OPKDIT, DAESL_US_MNTEST
* LIVE_GL: DAGP_US_OPKDIT, DAGP_US_OPKDIT
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


