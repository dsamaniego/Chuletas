# Procedimientos de guardia.

* [Levantar ordenadamente un entorno](https://datiobd.atlassian.net/wiki/spaces/OP/pages/126222470/Platform+boot+up+procedure).
    - **Reiniciar el exhibitor**:
        1. Miramos qué nodo es el lider (`ping leader.mesos`).
        2. Vamos reiniciando los nodos esclavos uno a uno (para que no se pierda el quorum).
        3. Reiniciamos el nodo que hace de lider, en ese momento, habrá una renegociación y se promocionará un nuevo lider de Mesos.
* [Rearrancar DC/OS](https://datiobd.atlassian.net/wiki/spaces/OP/pages/88541924)
* ¿Qué mirar en caso de caída?
* [Juanitor](https://datiobd.atlassian.net/wiki/spaces/OP/pages/582320171/Juanitor.+Limpieza+recursos+reservados+en+Mesos) - Para cuando veamos que hay muchos recursos pillados en Mesos.
* Mesos
* Exhibitor: OJO, aquí se va si no hay mas remedio. (URL tipo: https://daas.work.es.ether.igrupobbva/admin/exhibitor/)
* Reiniciar un contenedor:
    - Hay que conectarse a la máquina donde está corriendo el contenedor, lo identificamos con un `docker ps`y se hace un `docker restart <id>`.

Para conectarse a los DC/OS en plan emergencia, si es que no se llega con el usuario XE, hay un usuario _internaldeployer_ que nos permite conectarnos a todos lados. Para ver la contraseña, nos conectamos al id2 y miramos en el entorno...

Si hay algo que en los DC/OS no podamos ver bien, podemos subir el nivel de login metiendo la siguiente variable: 
    "logging.level.com.datio.mesos.reporter": "DEBUG",

curl https://pgmeme.

# Conexiones de "emergencia" a los DCOS...

Si por lo que sea se nos ha roto la conexión a los DCOS con nuestro usuario XE... podemos usar el usuario internalDeployer.

la contraseña está en el id2 en rutas tipo /data/us/live01.daas.us.igrupobbva/pass/ldap/internalDeployer

# DNSmasq

Para usar con la VPNaaS seguir las instrucciones del siguiente [documento](https://docs.google.com/document/d/1cjZgi1jI-8CRApHlqfOeEc1vJ4e0eAD7pv12gYRYrYk/edit?ts=5c077bdb)

