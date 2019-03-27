# Intelligence

* Dar de alta las imágenes analíticas de Intelligence:
~~~bash
curl -XPOST -k -H "Content-Type: application/json"  http://intest.marathon.l4lb.play01.daas.gl.igrupobbva:8003/dockerimages -d '{ "dockerImage": "nexus.daas.work.es.ether.igrupobbva/repository/es-docker/stratio/analytic-environment:x.x.x", "idImage": "defaultAnalytic" }'
~~~
* Dar de alta el catálogo de crossdata:
~~~bash
curl -XPOST -k -H "Content-Type: application/json" --data "@newcrossdatacatalog.json" http://intest.marathon.l4lb.play01.daas.gl.igrupobbva:8003/crossdatacatalogs
~~~
* Alta de usuario:
~~~bash
curl -XPOST -k -H "Content-Type: application/json" --data "@userXE65803.json" "http://intest.marathon.l4lb.priv02.daas.gl.igrupobbva:8003/users
~~~

# Parámetros de interés del descriptor

* name y osUid: nombre y uid (como hasta ahora)
* idAnalyticimage e idSparkImage: id de la imagen analítica que se va a usar (a diferencia de versiones anteriores, la imagen analítica se usa también como executor)
* analyticResources (nCores y mem): cores y GBs de memoria para el contenedor analítico
* idCrossdataCatalog: catálogo crossdata que se quiera asociar al usuario, definido previamente
* maxOpenNotebooks: como en la versión anterior, número máximo de notebooks abiertos simultáneamente (0 es sin límite)
* kernels: por cada kernel tenemos nombre y tipo de kernel
* master
* sparkResources (spark_cores_max y spark_executor_memory): definen el número máximo de executors y su memoria.
* sparkAdvancedConfiguration:
* spark.mesos.executor.docker.parameters=user='intelligence' : este es un parámetro nuevo que se añade para que el contenedor de los executors se ejecute con usuario intelligence en lugar de root como hasta ahora y era un requisito de seguridad derivado de la auditoría que se hizo en septiembre
* spark.mesos.driver.failoverTimeout=120 y spark.network.timeout=600s: dos parámetros que se meten para mejorar el funcionamiento al arrancar los kernels
* spark.app.name: etiqueta con el nombre de usuario y el del sandbox al que pertenece, así como el nombre del kernel
* spark.driver.memory=2g : memoria del driver
* spark.executor.cores=2 : cores por executor
* cadena de --jars, --py-files o --properties-file : configuración que se añade para que funcionen los kernels con graphframes o pymazinger
* sparkDynamicAllocation: por ahora a false hasta que se empiece a utilizar
* artifactDeployAllowed: permite el uso de la carpeta artifacts para que los usuarios prueben sus .zip o .jars
* artifactsFolderPath: "artifacts" : carpeta donde se van a encontrar las carpetas python y scala, para el despliegue de artifacts mencionados en el punto anterior, esta carpetas hay que crearlas en la ruta /intelligence/in<UUAA>/analytic/users/<User>/workspace/artifacts/{"scala" y "python"}
