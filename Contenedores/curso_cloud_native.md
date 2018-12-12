# Curso Cloud-Native.

[http://redhat.cloudnative.com]
[https://github.com/openshift/openshift-cns-testdrive]

## OpenShift
* Multilenguaje.
* Automatizable.
* Basado en kubernetes, basado en estándares.
* OpenSource.
* Multitenant.

## Linux containers.
* __De cara a infraestructuras__: Procesos de aplicación en un kernel compartido. Son ligeros y simples que mas VMs. Son portables.
* __De cara a desarrollo__: Aplicaciones empaquetadas con todas sus dependencias, que se depliegan en segundos, fácilmente compartibles y accesibles.

No tienes que emular que tienes un servidor como es el caso de la VMs, lo que proporciona:
* Aislamiento de contenedores.
* Kernel compartido.
* Bajo uso de recursos.
* Memoria y Computo se usan cuando se necesitan.

La VMs no son portables entre hipervisores, pero los contenedores sí.

Portabilidad con contenedores:
RHEL Container + RHEL Host = Portabilidad garantizada con contenedores.

Como los contenedores están formados por capas, las aplicaciones que usen las mismas capas, sólo tendrán que bajar junto a ellas las capas que difieran.

### cri-o
Capa de intermediaria (proxy) entre kubernetes y el gestor de contenedores.
OCI-compliant (Open Container Initiative)

# OpenShift (Arquitectura)
Un master con:
* API/Autenticación
* DataStore
* Scheduler
* Healt/Scaling

Las aplicaciones corren en contenedores, que están dentro de pods para kubernetes.

Pod --> Entidad lógica que junta contenedores para dar soporte a una aplicación.
Los pods se levangan en los nodos (en el nodo que sea).

El master es que que decide dónde se van los pods.

Incluye el Registry (almacen de imágenes de contenedores).
Incluye almacenamiento persistente.

La capa de servicio es la que enruta entre PODs.
La capa de enrutamiento permite acceder desde fuera de nuestra infraestructura a nuestros PODs, sin pasar por la capa de servicio.

Aceso via WEB, CLI, IDE y API.

## Almacenamiento.
PVC -- PersistentVolumeClaim -- Petición de volumen persistente.
SC -- StorageClass
SB -- StorageBackend -- donde se crea el amacenamiento.
PV -- PersistentVolume -- Esto ya puede ser usado por mi aplicación.

El almacenamiento elegido es Gluster-FS -- Sistema distribuido. (Triplicado)
Como todo almacenamiento replicado necesita ancho de banda (megor 10 GBs)
HEKETI expone un API REST para hacer peticiones a gluster-FS.

Las peticiones de volúmenes le llegan al POD de HEKETI que hace peticiones a los PODs de Gluster.

# Usando OpenShift
```bash
[cloud-user@master ~]$ oc login -u system:admin
Logged into "https://master.internal.aws.testdrive.openshift.com:443" as "system:admin" using existing credentials.

You have access to the following projects and can switch between them with 'oc project <projectname>':

  * default
    kube-public
    kube-system
    management-infra
    openshift
    openshift-console
    openshift-infra
    openshift-logging
    openshift-metrics
    openshift-monitoring
    openshift-node
    openshift-sdn
    openshift-web-console
    storage

Using project "default".
[cloud-user@master ~]$ oc get nodes
NAME                                          STATUS    ROLES     AGE       VERSION
infra.internal.aws.testdrive.openshift.com    Ready     infra     38m       v1.11.0+d4cacc0
master.internal.aws.testdrive.openshift.com   Ready     master    42m       v1.11.0+d4cacc0
node01.internal.aws.testdrive.openshift.com   Ready     compute   38m       v1.11.0+d4cacc0
node02.internal.aws.testdrive.openshift.com   Ready     compute   38m       v1.11.0+d4cacc0
node03.internal.aws.testdrive.openshift.com   Ready     compute   38m       v1.11.0+d4cacc0
[cloud-user@master ~]$ kubectl get nodes
NAME                                          STATUS    ROLES     AGE       VERSION
infra.internal.aws.testdrive.openshift.com    Ready     infra     39m       v1.11.0+d4cacc0
master.internal.aws.testdrive.openshift.com   Ready     master    42m       v1.11.0+d4cacc0
node01.internal.aws.testdrive.openshift.com   Ready     compute   39m       v1.11.0+d4cacc0
node02.internal.aws.testdrive.openshift.com   Ready     compute   39m       v1.11.0+d4cacc0
node03.internal.aws.testdrive.openshift.com   Ready     compute   39m       v1.11.0+d4cacc0
```

Usando proyecto openshift-metrics:
[cloud-user@master ~]$ oc project openshift-metrics 
Now using project "openshift-metrics" on server "https://master.internal.aws.testdrive.openshift.com:443".

Obteniendo información del proyecto
[cloud-user@master ~]$ oc get all
NAME                                 READY     STATUS    RESTARTS   AGE
pod/prometheus-0                     6/6       Running   0          36m
pod/prometheus-node-exporter-2tm6c   1/1       Running   0          36m
pod/prometheus-node-exporter-5p7fr   1/1       Running   0          36m
pod/prometheus-node-exporter-87qrl   1/1       Running   0          36m
pod/prometheus-node-exporter-n6hnb   1/1       Running   0          36m
pod/prometheus-node-exporter-v4bvl   1/1       Running   0          36m

NAME                               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/alertmanager               ClusterIP   172.30.10.184    <none>        443/TCP    36m
service/alerts                     ClusterIP   172.30.191.105   <none>        443/TCP    36m
service/prometheus                 ClusterIP   172.30.120.97    <none>        443/TCP    36m
service/prometheus-node-exporter   ClusterIP   None             <none>        9102/TCP   36m

NAME                                      DESIRED   CURRENT   READY     UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/prometheus-node-exporter   5         5         5         5            5           <none>          36m

NAME                          DESIRED   CURRENT   AGE
statefulset.apps/prometheus   1         1         36m

NAME                                    HOST/PORT                                                                      PATH      SERVICES       PORT      TERMINATION   WILDCARD
route.route.openshift.io/alertmanager   alertmanager-openshift-metrics.apps.179523625278.aws.testdrive.openshift.com             alertmanager   <all>     reencrypt     None
route.route.openshift.io/alerts         alerts-openshift-metrics.apps.179523625278.aws.testdrive.openshift.com                   alerts         <all>     reencrypt     None
route.route.openshift.io/prometheus     prometheus-openshift-metrics.apps.179523625278.aws.testdrive.openshift.com               prometheus     <all>     reencrypt     None

Describe el objeto:

daemonset recursos de kubernetes.

[cloud-user@master ~]$ oc describe daemonset  prometheus-node-exporter
Name:           prometheus-node-exporter
Selector:       app=prometheus-node-exporter,role=monitoring
Node-Selector:  <none>
Labels:         app=prometheus-node-exporter
                role=monitoring
Annotations:    kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"extensions/v1beta1","kind":"DaemonSet","metadata":{"annotations":{},"labels":{"app":"prometheus-node-exporter","role":"monitoring"},"nam...
Desired Number of Nodes Scheduled: 5
Current Number of Nodes Scheduled: 5
Number of Nodes Scheduled with Up-to-date Pods: 5
Number of Nodes Scheduled with Available Pods: 5
Number of Nodes Misscheduled: 0
Pods Status:  5 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:           app=prometheus-node-exporter
                    role=monitoring
  Service Account:  prometheus-node-exporter
  Containers:
   node-exporter:
    Image:      support.internal.aws.testdrive.openshift.com:5000/openshift3/prometheus-node-exporter:v3.11.16
    Port:       9102/TCP
    Host Port:  9102/TCP
    Args:
      --no-collector.wifi
      --web.listen-address=:9102
    Limits:
      cpu:     200m
      memory:  50Mi
    Requests:
      cpu:        100m
      memory:     30Mi
    Environment:  <none>
    Mounts:
      /host/proc from proc (ro)
      /host/sys from sys (ro)
  Volumes:
   proc:
    Type:          HostPath (bare host directory volume)
    Path:          /proc
    HostPathType:  
   sys:
    Type:          HostPath (bare host directory volume)
    Path:          /sys
    HostPathType:  
Events:
  Type    Reason            Age   From                  Message
  ----    ------            ----  ----                  -------
  Normal  SuccessfulCreate  38m   daemonset-controller  Created pod: prometheus-node-exporter-2tm6c
  Normal  SuccessfulCreate  38m   daemonset-controller  Created pod: prometheus-node-exporter-87qrl
  Normal  SuccessfulCreate  38m   daemonset-controller  Created pod: prometheus-node-exporter-5p7fr
  Normal  SuccessfulCreate  38m   daemonset-controller  Created pod: prometheus-node-exporter-v4bvl
  Normal  SuccessfulCreate  38m   daemonset-controller  Created pod: prometheus-node-exporter-n6hnb


sacar rutas:
```bash
[cloud-user@master ~]$ oc get routes
NAME           HOST/PORT                                                                      PATH      SERVICES       PORT      TERMINATION   WILDCARD
alertmanager   alertmanager-openshift-metrics.apps.179523625278.aws.testdrive.openshift.com             alertmanager   <all>     reencrypt     None
alerts         alerts-openshift-metrics.apps.179523625278.aws.testdrive.openshift.com                   alerts         <all>     reencrypt     None
prometheus     prometheus-openshift-metrics.apps.179523625278.aws.testdrive.openshift.com               prometheus     <all>     reencrypt     None
```
el equipo de comunicaciones nos tendrá que poner el dns que apunte a *.apps.179523625278.aws.testdrive.openshift.com para que funcionen las cosas.


Almacenamiento:
~~~ bash
[cloud-user@master ~]$ heketi-cli cluster list
Clusters:
Id:8c8d67d95da522094d691cd46f4132ac [file][block]
[cloud-user@master ~]$ heketi-cli topology info

Cluster Id: 8c8d67d95da522094d691cd46f4132ac

    File:  true
    Block: true

    Volumes:

	Name: heketidbstorage
	Size: 2
	Id: 75a21d0c6a450f897864f756bef6c643
	Cluster Id: 8c8d67d95da522094d691cd46f4132ac
	Mount: 10.0.4.93:heketidbstorage
	Mount Options: backup-volfile-servers=10.0.1.46,10.0.3.191
	Durability Type: replicate
	Replica: 3
	Snapshot: Disabled

		Bricks:
			Id: 2eaf38c26c5681e430337ff67937e900
			Path: /var/lib/heketi/mounts/vg_205bc367df74e2f01d22ec96302a53c9/brick_2eaf38c26c5681e430337ff67937e900/brick
			Size (GiB): 2
			Node: bd6ba544e4a39827e89f6233c48fde6a
			Device: 205bc367df74e2f01d22ec96302a53c9

			Id: 39ecaa7cdece093f00ad76afc17a0e1f
			Path: /var/lib/heketi/mounts/vg_dd92c6c23288e7eba655e43124419a8c/brick_39ecaa7cdece093f00ad76afc17a0e1f/brick
			Size (GiB): 2
			Node: 68374915a84ac9c82ba651b8d8cf79fd
			Device: dd92c6c23288e7eba655e43124419a8c

			Id: 83c4382c3744c3f3b523e6d915ec824e
			Path: /var/lib/heketi/mounts/vg_5a86a3ef93b7baded8886b956ca96da8/brick_83c4382c3744c3f3b523e6d915ec824e/brick
			Size (GiB): 2
			Node: 10dc36658890e398d205ab7ee7d5ac74
			Device: 5a86a3ef93b7baded8886b956ca96da8


    Nodes:

	Node Id: 10dc36658890e398d205ab7ee7d5ac74
	State: online
	Cluster Id: 8c8d67d95da522094d691cd46f4132ac
	Zone: 3
	Management Hostnames: node03.internal.aws.testdrive.openshift.com
	Storage Hostnames: 10.0.4.93
	Devices:
		Id:5a86a3ef93b7baded8886b956ca96da8   Name:/dev/xvdd           State:online    Size (GiB):49      Used (GiB):2       Free (GiB):47      
			Bricks:
				Id:83c4382c3744c3f3b523e6d915ec824e   Size (GiB):2       Path: /var/lib/heketi/mounts/vg_5a86a3ef93b7baded8886b956ca96da8/brick_83c4382c3744c3f3b523e6d915ec824e/brick

	Node Id: 68374915a84ac9c82ba651b8d8cf79fd
	State: online
	Cluster Id: 8c8d67d95da522094d691cd46f4132ac
	Zone: 1
	Management Hostnames: node01.internal.aws.testdrive.openshift.com
	Storage Hostnames: 10.0.1.46
	Devices:
		Id:dd92c6c23288e7eba655e43124419a8c   Name:/dev/xvdd           State:online    Size (GiB):49      Used (GiB):2       Free (GiB):47      
			Bricks:
				Id:39ecaa7cdece093f00ad76afc17a0e1f   Size (GiB):2       Path: /var/lib/heketi/mounts/vg_dd92c6c23288e7eba655e43124419a8c/brick_39ecaa7cdece093f00ad76afc17a0e1f/brick

	Node Id: bd6ba544e4a39827e89f6233c48fde6a
	State: online
	Cluster Id: 8c8d67d95da522094d691cd46f4132ac
	Zone: 2
	Management Hostnames: node02.internal.aws.testdrive.openshift.com
	Storage Hostnames: 10.0.3.191
	Devices:
		Id:205bc367df74e2f01d22ec96302a53c9   Name:/dev/xvdd           State:online    Size (GiB):49      Used (GiB):2       Free (GiB):47      
			Bricks:
				Id:2eaf38c26c5681e430337ff67937e900   Size (GiB):2       Path: /var/lib/heketi/mounts/vg_205bc367df74e2f01d22ec96302a53c9/brick_2eaf38c26c5681e430337ff67937e900/brick
~~~

OJO: aunque está por triplicado, si se cae uno no podremos crear nuevos volúmenes, eso sí, los que estén seguiran estando.

## Aplicaciones en OpenShift
[cloud-user@master ~]$ oc new-project app-management
Now using project "app-management" on server "https://master.internal.aws.testdrive.openshift.com:443".

You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app centos/ruby-25-centos7~https://github.com/sclorg/ruby-ex.git

to build a new example application in Ruby.

cloud-user@master ~]$ oc status
In project app-management on server https://master.internal.aws.testdrive.openshift.com:443

You have no services, deployment configs, or build configs.
Run 'oc new-app' to create an application.
[cloud-user@master ~]$ ^C
[cloud-user@master ~]$ oc new-app docker.io/siamaksade/mapit
--> Found Docker image 9eca6ec (16 months old) from docker.io for "docker.io/siamaksade/mapit"

    * An image stream tag will be created as "mapit:latest" that will track this image
    * This image will be deployed in deployment config "mapit"
    * Ports 8080/tcp, 8778/tcp, 9779/tcp will be load balanced by service "mapit"
      * Other containers can access this service through the hostname "mapit"

--> Creating resources ...
    imagestream.image.openshift.io "mapit" created
    deploymentconfig.apps.openshift.io "mapit" created
    service "mapit" created
--> Success
    Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
     'oc expose svc/mapit
    Run 'oc status' to view your app.

### Rutas.
para que funcione.

El balanceador tiene que estar apuntado al 443 y al 80 y aceptar esos tráficos.
En el dns la IP del balanceador tiene que corresponderse con *.aws....

Así todo lo que llegue al balanceador llegará a los nodos con toda la cabecera.


### Procesos.
Importante... hay veces (sobre todo en versiones antigüas, en que las aplicaciones tardan mucho en arrancar, y nuestro master lo está matando porque tarda maás que el tiempo prefijado.)

Hay que distinguir entre vivo (live) y listo (ready).

¿Cómo sabemos que está ready?, haciendo algún tipo de peticiones, lo que se hace es que se desvía el tráfico hacia los pods listos hasta que estón listos los vivos.

Cualquier cambio en un DeployementConfig implica la muerte de los pods y el arranque de otros con el cambio aplicado.

Meterse dentro de un POD:
[cloud-user@master ~]$ oc get pods
NAME            READY     STATUS    RESTARTS   AGE
mapit-1-pdnmv   1/1       Running   0          39m
[cloud-user@master ~]$ oc rsh mapit-1-pdnmv

[cloud-user@master ~]$ oc rsh mapit-1-pdnmv cat /etc/hosts
# Kubernetes-managed hosts file.
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
fe00::0	ip6-mcastprefix
fe00::1	ip6-allnodes
fe00::2	ip6-allrouters
10.128.2.2	mapit-1-pdnmv
