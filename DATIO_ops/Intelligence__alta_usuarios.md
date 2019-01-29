Buenas, como ya hemos comentado en anteriores ocasiones, tenemos la intención de desplegar una nueva versión de Intelligence, que enseñamos en el DDD de la semana pasada, a la mayor brevedad posible.

Esta actualización va a suponer un cambio en la forma de gestionar y dar de alta/modificar usuarios. Se va a dejar de usar el containers.config y crossdata_users.config y se pasa a gestionar todo mediante llamadas a la API.

Desde arquitectura, deben coger esta plantilla como modelo para alta de usuarios y de imágenes y catálogos (esta parte ya la tienen), igual que desde soporte modificar los jenkins que tienen ahora mismo para dar de alta nuevo usuario. Creo que el equipo de sandbox también tiene que usar estas plantillas para la gestión de sandboxes que se va a hacer desde el sandbox manager.
En primer lugar, para dar de alta las imágenes analíticas de Intelligence:
curl -XPOST -k -H "Content-Type: application/json"  http://intest.marathon.l4lb.play01.daas.gl.igrupobbva:8003/dockerimages -d '{ "dockerImage": "nexus.daas.work.es.ether.igrupobbva/repository/es-docker/stratio/analytic-environment:0.19.1-upgrade3-RC13", "idImage": "defaultAnalytic" }'
en el que se especifica la imagen a dar de alta y su id (este se usará después para la configuración de usuario).

Dar de alta el catálogo de crossdata:
curl -XPOST -k -H "Content-Type: application/json" --data "@newcrossdatacatalog.json" http://intest.marathon.l4lb.play01.daas.gl.igrupobbva:8003/crossdatacatalogs

con el contenido de newcrossdatacatalogs.json siendo:
{
    "cacheEnabled":"true",
    "cacheTtl":"60",
    "compatibilityWithSecurityMode":"false",
    "connectionString":"zk-0001.zk-sandbox.mesos:2181,zk-0002.zk-sandbox.mesos:2181,zk-0003.zk-sandbox.mesos:2181",
    "connectionTimeout":0,
    "governance": "false",
    "idCrossdataCatalog":"zookeeperCatalog",
    "persistence":"parquet",
    "prefix":"xd-test-sandbox",
    "retryAttempts":5,
    "retryInterval":10000,
    "sessionTimeout":60000,
    "sqlNativeQueries":"true",
    "storagePath":"/tmp",
    "stratioSecurity":"false",
    "stratioSecurityMode":"tls"
}

he puesto en negrita los parámetros de "interés": 
la connectionString no debería variar, ya que en todos los entornos debería ser el zk-sandbox.
el idCrossdataCatalog es el que se va a especificar en la configuración del usuario, habrá que tenerlo en cuenta en el caso de que haya más de un catálogo al que pueda acceder un usuario.
el prefix nos indica el catálogo crossdata al que se conecta el usuario.
se pueden dar de alta varios catálogos de crossdata y luego asignarselos al usuario dependiendo del uso que vaya a hacer.

Por último, alta de usuario:
curl -XPOST -k -H "Content-Type: application/json" --data "@userXE65803.json" "http://intest.marathon.l4lb.priv02.daas.gl.igrupobbva:8003/users

con el contenido de userXE65803.json:

{
    "name": "XE65803",
    "osUid": "904501",
    "idAnalyticimage": "defaultAnalytic",
    "analyticResources": {
        "nCores": "4.0",
        "mem": "12288"
    },
    "idCrossdataCatalog": "zookeeperCatalog",
    "maxOpenNotebooks": "0",
    "userSecurityConfiguration": {
        "modelDeploymentAllowed": true,
        "sparkWithKerberos": true,
        "tlsDatastores": false,
        "dbPassword": false
    },
    "kernels": [
        {
            "nameKernel": "spark2python3",
            "typeKernel": "spark-python",
            "master": "mesos://leader.mesos:5050",
            "sparkResources": {
		        "spark_cores_max": "2",
		        "spark_executor_memory": "8g"
	        },
            "idSparkImage": "defaultAnalytic",
            "sparkAdvancedConfiguration": "--conf spark.mesos.executor.docker.parameters=user='intelligence' --conf spark.mesos.driver.failoverTimeout=120 --conf spark.network.timeout=600s --conf spark.app.name=in-test-intest-XE65803-spark2python3 --conf spark.sql.sources.parallelPartitionDiscovery.threshold=10000 --conf spark.task.maxFailures=20 --conf spark.driver.memory=2g --conf spark.executor.cores=2 --jars /var/sds/intelligence/commons/datio_deps.jar --py-files /usr/local/share/pymazinger/pymazinger.zip --properties-file /usr/local/lib/python3.5/dist-packages/bigdl/share/conf/spark-bigdl.conf",
            "sparkDynamicAllocation": false
        },
        {
            "nameKernel": "graphframes",
            "typeKernel": "spark-python",
            "master": "mesos://leader.mesos:5050",
            "sparkResources": {
                "spark_cores_max": "2",
                "spark_executor_memory": "8g"
            },
            "idSparkImage": "defaultAnalytic",
            "sparkAdvancedConfiguration": "--conf spark.mesos.executor.docker.parameters=user='intelligence' --conf spark.mesos.driver.failoverTimeout=120 --conf spark.network.timeout=600s --conf spark.app.name=in-test-intest-XE65803-graphframe --conf spark.sql.sources.parallelPartitionDiscovery.threshold=10000 --conf spark.task.maxFailures=20 --conf spark.driver.memory=2g --conf spark.executor.cores=2 --py-files /var/sds/intelligence/graphframes/graphframefiles.zip --jars /var/sds/intelligence/graphframes/graphframes-0.6.0-spark2.2-s_2.11.jar,/var/sds/intelligence/graphframes/scala-logging-api_2.11-2.1.2.jar,/var/sds/intelligence/graphframes/scala-logging-slf4j_2.11-2.1.2.jar",
            "sparkDynamicAllocation": false
        },
        {
            "nameKernel": "spark2scalatoree",
            "typeKernel": "spark-scala",
            "master": "mesos://leader.mesos:5050",
            "sparkResources": {
                "spark_cores_max": "2",
                "spark_executor_memory": "8g"
            },
            "idSparkImage": "defaultAnalytic",
            "sparkAdvancedConfiguration": "--conf spark.mesos.executor.docker.parameters=user='intelligence' --conf spark.mesos.driver.failoverTimeout=120 --conf spark.network.timeout=600s --conf spark.app.name=in-test-intest-XE65803-spark2scalatoree --conf spark.sql.sources.parallelPartitionDiscovery.threshold=10000 --conf spark.task.maxFailures=20 --conf spark.driver.memory=2g --conf spark.executor.cores=2",
            "sparkDynamicAllocation": false
        },
        {
            "nameKernel": "SparkR - Spark 2.2.0",
            "typeKernel": "spark-r",
            "master": "mesos://leader.mesos:5050",
            "sparkResources": {
                "spark_cores_max": "2",
                "spark_executor_memory": "8g"
            },
            "idSparkImage": "defaultAnalytic",
            "sparkAdvancedConfiguration": "--conf spark.mesos.executor.docker.parameters=user='intelligence' --conf spark.mesos.driver.failoverTimeout=120 --conf spark.network.timeout=600s --conf spark.app.name=in-test-intest-XE65803-sparkr --conf spark.sql.sources.parallelPartitionDiscovery.threshold=10000 --conf spark.task.maxFailures=20 --conf spark.driver.memory=2g --conf spark.executor.cores=2",
            "sparkDynamicAllocation": false
        },
        {
            "nameKernel": "local-pyspark",
            "typeKernel": "spark-python",
            "master": "local[*]",
            "sparkResources": {
                "spark_cores_max": "1",
                "spark_executor_memory": "1g"
            },
            "idSparkImage": "defaultAnalytic",
            "sparkAdvancedConfiguration": "--conf spark.mesos.executor.docker.parameters=user='intelligence' --conf spark.mesos.driver.failoverTimeout=120 --conf spark.network.timeout=600s --conf spark.sql.sources.parallelPartitionDiscovery.threshold=10000 --conf spark.task.maxFailures=20 --jars /var/sds/intelligence/commons/datio_deps.jar --py-files /usr/local/share/pymazinger/pymazinger.zip --properties-file /usr/local/lib/python3.5/dist-packages/bigdl/share/conf/spark-bigdl.conf",
            "sparkDynamicAllocation": false
        },
        {
            "nameKernel": "local-graphframes",
            "typeKernel": "spark-python",
            "master": "local[*]",
            "sparkResources": {
                "spark_cores_max": "1",
                "spark_executor_memory": "1g"
            },
            "idSparkImage": "defaultAnalytic",
            "sparkAdvancedConfiguration": "--conf spark.mesos.executor.docker.parameters=user='intelligence' --conf spark.mesos.driver.failoverTimeout=120 --conf spark.network.timeout=600s --conf spark.sql.sources.parallelPartitionDiscovery.threshold=10000 --conf spark.task.maxFailures=20 --py-files /var/sds/intelligence/graphframes/graphframefiles.zip --jars /var/sds/intelligence/graphframes/graphframes-0.6.0-spark2.2-s_2.11.jar,/var/sds/intelligence/graphframes/scala-logging-api_2.11-2.1.2.jar,/var/sds/intelligence/graphframes/scala-logging-slf4j_2.11-2.1.2.jar",
            "sparkDynamicAllocation": false
        },
        {
            "nameKernel": "local-scala",
            "typeKernel": "spark-scala",
            "master": "local[*]",
            "sparkResources": {
                "spark_cores_max": "1",
                "spark_executor_memory": "1g"
            },
            "idSparkImage": "defaultAnalytic",
            "sparkAdvancedConfiguration": "--conf spark.mesos.executor.docker.parameters=user='intelligence' --conf spark.mesos.driver.failoverTimeout=120 --conf spark.network.timeout=600s --conf spark.sql.sources.parallelPartitionDiscovery.threshold=10000 --conf spark.task.maxFailures=20",
            "sparkDynamicAllocation": false
        },
        {
            "nameKernel": "local-R",
            "typeKernel": "spark-r",
            "master": "local[*]",
            "sparkResources": {
                "spark_cores_max": "1",
                "spark_executor_memory": "1g"
            },
            "idSparkImage": "defaultAnalytic",
            "sparkAdvancedConfiguration": "--conf spark.mesos.executor.docker.parameters=user='intelligence' --conf spark.mesos.driver.failoverTimeout=120 --conf spark.network.timeout=600s --conf spark.sql.sources.parallelPartitionDiscovery.threshold=10000 --conf spark.task.maxFailures=20",
            "sparkDynamicAllocation": false
        }
    ],
    "shuffleServicePath": "/var/lib/spark_data",
    "artifactDeployAllowed": true,
    "artifactsFolderPath": "artifacts",
    "logLevel": "DEBUG"
}

parámetros de interés: 
name y osUid: nombre y uid (como hasta ahora)
idAnalyticimage e idSparkImage: id de la imagen analítica que se va a usar (a diferencia de versiones anteriores, la imagen analítica se usa también como executor)
analyticResources (nCores y mem): cores y GBs de memoria para el contenedor analítico
idCrossdataCatalog: catálogo crossdata que se quiera asociar al usuario, definido previamente
maxOpenNotebooks: como en la versión anterior, número máximo de notebooks abiertos simultáneamente (0 es sin límite)
kernels: por cada kernel tenemos
nombre y tipo de kernel
master
sparkResources (spark_cores_max y spark_executor_memory): definen el número máximo de executors y su memoria.
sparkAdvancedConfiguration:
spark.mesos.executor.docker.parameters=user='intelligence' : este es un parámetro nuevo que se añade para que el contenedor de los executors se ejecute con usuario intelligence en lugar de root como hasta ahora y era un requisito de seguridad derivado de la auditoría que se hizo en septiembre
spark.mesos.driver.failoverTimeout=120 y spark.network.timeout=600s: dos parámetros que se meten para mejorar el funcionamiento al arrancar los kernels
spark.app.name: etiqueta con el nombre de usuario y el del sandbox al que pertenece, así como el nombre del kernel
spark.driver.memory=2g : memoria del driver
spark.executor.cores=2 : cores por executor
cadena de --jars, --py-files o --properties-file : configuración que se añade para que funcionen los kernels con graphframes o pymazinger
sparkDynamicAllocation: por ahora a false hasta que se empiece a utilizar
artifactDeployAllowed: permite el uso de la carpeta artifacts para que los usuarios prueben sus .zip o .jars
artifactsFolderPath: "artifacts" : carpeta donde se van a encontrar las carpetas python y scala, para el despliegue de artifacts mencionados en el punto anterior, esta carpetas hay que crearlas en la ruta /intelligence/in<UUAA>/analytic/users/<User>/workspace/artifacts/{"scala" y "python"}

Para cualquier duda que tengan me pueden preguntar, o si quieren montamos una reunión para aclarar aspectos que no queden del todo claros.