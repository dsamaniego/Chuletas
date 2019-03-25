# Operativa para kafka

Para consultar los miembros del cluster:

[root@agent-1 LIVE02 ~]# curl 192.168.192.57:10223/v1/endpoints/broker
{
"address": [
"192.168.192.20:9092",
"192.168.192.167:9092",
"192.168.192.177:9092"
],
"dns": [
"kafka-0-broker.kf-shared.autoip.dcos.thisdcos.directory:9092",
"kafka-1-broker.kf-shared.autoip.dcos.thisdcos.directory:9092",
"kafka-2-broker.kf-shared.autoip.dcos.thisdcos.directory:9092"
],
"vip": "broker.kf-shared.l4lb.thisdcos.directory:9092"
}

Obtener elementos del cluster

[root@agent-1 LIVE02 ~]# curl -X GET 192.168.192.57:10223/v1/pod
[
"kafka-0",
"kafka-1",
"kafka-2"
]

[root@agent-1 LIVE02 ~]# curl -X GET 192.168.192.57:10223/v1/pod/kafka-2/status
{
"name": "kafka-2",
"tasks": [{
"name": "kafka-2-broker",
"id": "kafka-2-broker__3e9f8ca4-a69e-4998-9ff1-893a78bb70f9",
"status": "LOST"
}]
}

Reiniciar nodo, para que caiga en el mismo

[root@agent-1 LIVE02 ~]# curl -X POST 192.168.192.57:10223/v1/pod/kafka-2/restart


Reiniciar nodo, para que caiga en otro nodo

[root@agent-1 LIVE02 ~]# curl -X POST 192.168.192.57:10223/v1/pod/kafka-2/replace
{
"pod": "kafka-2",
"tasks": ["kafka-2-broker"]
}

Para hacer teardown del cluster de Kafka. Desde un agente ejecutamos:

curl -v -X DELETE  "http://192.168.192.27:10143/v1/teardown?user=firstGosec&pass=XXXXXXXXXXXXXXX&tenant=NONE"

Usaremos la IP y puerto del coordinador. También necesitaremos usar un usuario y password que tenga permisos para entrar en DCOS.

Una vez hecho y comprobado que elimina los broker de DCOS procedemos a eliminar el corrdinador haciendo destry desde el mismo DCOS.


/Si tras reiniciar el coordinador vemos el siguiente fallo significará que la VIP se ha modificado. Para corregirlo debemos entrar en marathon y cambiarlo al valor /api.kf-shared:80



El error es:


I0920 08:33:11.036240 20391 fetcher.cpp:409] Fetching URI 'http://api.kf-shared.marathon.l4lb.thisdcos.directory/v1/artifacts/template/4e113a69-aa6f-471f-950b-0f38b61e8a18/kafka/broker/manifest-json'
I0920 08:33:11.036265 20391 fetcher.cpp:250] Fetching directly into the sandbox directory
I0920 08:33:11.036455 20391 fetcher.cpp:187] Fetching URI 'http://api.kf-shared.marathon.l4lb.thisdcos.directory/v1/artifacts/template/4e113a69-aa6f-471f-950b-0f38b61e8a18/kafka/broker/manifest-json'
I0920 08:33:11.036484 20391 fetcher.cpp:134] Downloading resource from 'http://api.kf-shared.marathon.l4lb.thisdcos.directory/v1/artifacts/template/4e113a69-aa6f-471f-950b-0f38b61e8a18/kafka/broker/manifest-json' to '/var/lib/mesos/slave/slaves/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-S1/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0809/executors/kafka__8ac92ab7-4c35-45c4-962a-1ec212c19ffe/runs/4767ad90-e748-42ba-8000-b01c6f2652eb/config-templates/manifest-json'
Failed to fetch 'http://api.kf-shared.marathon.l4lb.thisdcos.directory/v1/artifacts/template/4e113a69-aa6f-471f-950b-0f38b61e8a18/kafka/broker/manifest-json': Error downloading resource: Couldn't resolve host name
Failed to synchronize with agent (it's probably exited)
Para conectarnos a Kafka y comprobar que accedemos a los datos correctamente podemos seguir los siguiente pasos:

Nos conectamos por ssh al agente kafka-0-broker y ejecutamos  ps -aef |grep kafka | grep config/server.properties . 


[cloud-user@agent-30 WORK01 ~]$ ps -aef |grep kafka | grep config/server.properties
root     28636 28632  1 13:51 ?        00:00:43 /var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/jdk1.8.0_152/bin/java -Xms16284M -Xmx16284M -server -XX:+UseG1GC -XX:MaxGCPauseMillis=20 -XX:InitiatingHeapOccupancyPercent=35 -XX:+ExplicitGCInvokesConcurrent -Djava.awt.headless=true -Xloggc:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../logs/kafkaServer-gc.log -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=100M -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.port=9091 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=true -Dcom.sun.management.jmxremote.port=9091 -Dkafka.logs.dir=/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../logs -Dlog4j.configuration=file:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../config/log4j.properties -cp /var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/stratio-framework-common-logconfig-1.0.2-6c0cf6f/lib/*:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/eos-framework-kafka-auth-plugin-2.1.2-8b8042c/*:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/aopalliance-repackaged-2.5.0-b32.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/argparse4j-0.7.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/commons-lang3-3.5.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/connect-api-1.1.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/connect-file-1.1.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/connect-json-1.1.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/connect-runtime-1.1.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/connect-transforms-1.1.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/guava-20.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/hk2-api-2.5.0-b32.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/hk2-locator-2.5.0-b32.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/hk2-utils-2.5.0-b32.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jackson-annotations-2.9.4.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jackson-core-2.9.4.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jackson-databind-2.9.4.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jackson-jaxrs-base-2.9.4.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jackson-jaxrs-json-provider-2.9.4.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jackson-module-jaxb-annotations-2.9.4.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/javassist-3.20.0-GA.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/javassist-3.21.0-GA.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/javax.annotation-api-1.2.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/javax.inject-1.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/javax.inject-2.5.0-b32.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/javax.servlet-api-3.1.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/javax.ws.rs-api-2.0.1.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jersey-client-2.25.1.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jersey-common-2.25.1.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jersey-container-servlet-2.25.1.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jersey-container-servlet-core-2.25.1.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jersey-guava-2.25.1.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jersey-media-jaxb-2.25.1.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jersey-server-2.25.1.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jetty-client-9.2.24.v20180105.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jetty-continuation-9.2.24.v20180105.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jetty-http-9.2.24.v20180105.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jetty-io-9.2.24.v20180105.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jetty-security-9.2.24.v20180105.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jetty-server-9.2.24.v20180105.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jetty-servlet-9.2.24.v20180105.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jetty-servlets-9.2.24.v20180105.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jetty-util-9.2.24.v20180105.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/jopt-simple-5.0.4.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/kafka-clients-1.1.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/kafka-log4j-appender-1.1.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/kafka-streams-1.1.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/kafka-streams-examples-1.1.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/kafka-streams-test-utils-1.1.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/kafka-tools-1.1.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/kafka_2.11-1.1.0-sources.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/kafka_2.11-1.1.0-test-sources.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/kafka_2.11-1.1.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/log4j-1.2.17.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/lz4-java-1.4.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/maven-artifact-3.5.2.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/metrics-core-2.2.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/osgi-resource-locator-1.0.1.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/plexus-utils-3.1.0.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/reflections-0.9.11.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/rocksdbjni-5.7.3.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/scala-library-2.11.12.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/scala-logging_2.11-3.7.2.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/scala-reflect-2.11.12.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/slf4j-api-1.7.25.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/slf4j-log4j12-1.7.25.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/snappy-java-1.1.7.1.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/validation-api-1.1.0.Final.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/zkclient-0.10.jar:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/bin/../libs/zookeeper-3.5.3-beta.jar -DisThreadContextMapInheritable=true -Dlog4j2.enable.threadlocals=false -DLOGLEVEL_COM_MESOSPHERE=WARN -DLOGLEVEL_ORG_ELASTICSEARCH=WARN -DLOGLEVEL_ORG_APACHE_HADOOP=WARN -DLOGLEVEL_ORG_KAFKA=WARN -DLOGLEVEL_COM_STRATIO=INFO -DLOGLEVEL_ROOT=ERROR -DLOGLEVEL_COM_MESOSPHERE_SDK_EXECUTOR=FATAL -Dlog4j.configuration=file:///var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/stratio-framework-common-logconfig-1.0.2-6c0cf6f/conf/log4j.xml -Dlog4j.configurationFile=file:///var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/stratio-framework-common-logconfig-1.0.2-6c0cf6f/conf/log4j2.xml -Dlogback.configurationFile=/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/stratio-framework-common-logconfig-1.0.2-6c0cf6f/conf/logback.xml -Djava.security.auth.login.config=/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/config/kafka_server_jaas.conf -Djava.security.krb5.conf=/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/config/krb5.conf -Dsun.security.krb5.debug=true -javaagent:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/stratio-framework-common-logconfig-1.0.2-6c0cf6f/lib/stratio-framework-common-logconfig-1.0.2-6c0cf6f.jar -javaagent:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/jmxexporter/jmx_prometheus_javaagent-0.10.jar=9081:/var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/jmxexporter/prometheus-jmxexporter-config.yml kafka.Kafka /var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0/config/server.properties

De la parte final copiamos desde /var/lib/mesos hasta kafka_XXXXX. Accedemos al directorio.

[cloud-user@agent-30 WORK01 ~]$ cd /var/lib/mesos/slave/slaves/e85da82b-9962-4822-90b3-eb005f40b72d-S43/frameworks/4d7ce986-748a-4397-a3e0-df5e8cdb29ec-0732/executors/kafka__2356039d-59ab-40b7-b11c-cfdfc16a93cd/runs/b9ea5443-a205-45ff-b96e-3e34d5072b2c/kafka_2.11-1.1.0

Ejecutamos

[cloud-user@agent-6 WORK01 kafka_2.11-1.1.0]$ source ../eos-framework-kafka-2.1.2-8b8042c/set_env.sh
[cloud-user@agent-6 WORK01 kafka_2.11-1.1.0]$ bin/zookeeper-shell.sh zk-0001.zk-kafka.mesos:2182/dcos-service-kf-shared
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/var/lib/mesos/slave/slaves/e3a74d5d-519a-44e1-892b-8dd547b5c443-S18/frameworks/df936cef-916b-4cfc-b2c2-56889e6abd4a-0015/executors/kafka__d10b18d2-5e11-4e2f-b8ed-74eb7109dce6/runs/fa8d2a08-56f4-4258-a5dc-ab2b4c8cf755/stratio-framework-common-dyplon-1.0.2-6c0cf6f/lib/log4j-slf4j-impl-2.8.1.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/var/lib/mesos/slave/slaves/e3a74d5d-519a-44e1-892b-8dd547b5c443-S18/frameworks/df936cef-916b-4cfc-b2c2-56889e6abd4a-0015/executors/kafka__d10b18d2-5e11-4e2f-b8ed-74eb7109dce6/runs/fa8d2a08-56f4-4258-a5dc-ab2b4c8cf755/kafka_2.11-1.1.0/libs/slf4j-log4j12-1.7.25.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]
Connecting to zk-0001.zk-kafka.mesos:2182/dcos-service-kf-shared
Welcome to ZooKeeper!
JLine support is disabled
>>> KeyTabInputStream, readName(): GL.WORK01.BBVA.COM
>>> KeyTabInputStream, readName(): xglkfkdit1w
>>> KeyTab: load() entry length: 84; type: 18
>>> KeyTabInputStream, readName(): GL.WORK01.BBVA.COM
>>> KeyTabInputStream, readName(): xglkfkdit1w
>>> KeyTab: load() entry length: 68; type: 17
Looking for keys for: xglkfkdit1w@GL.WORK01.BBVA.COM
Java config name: /var/lib/mesos/slave/slaves/e3a74d5d-519a-44e1-892b-8dd547b5c443-S18/frameworks/df936cef-916b-4cfc-b2c2-56889e6abd4a-0015/executors/kafka__d10b18d2-5e11-4e2f-b8ed-74eb7109dce6/runs/fa8d2a08-56f4-4258-a5dc-ab2b4c8cf755/kafka_2.11-1.1.0/config/krb5.conf
Loaded from Java config
Added key: 17version: 2
Found unsupported keytype (18) for xglkfkdit1w@GL.WORK01.BBVA.COM
>>> KdcAccessibility: reset
Looking for keys for: xglkfkdit1w@GL.WORK01.BBVA.COM
Added key: 17version: 2
Found unsupported keytype (18) for xglkfkdit1w@GL.WORK01.BBVA.COM
Using builtin default etypes for default_tkt_enctypes
default etypes for default_tkt_enctypes: 17 16 23.
>>> KrbAsReq creating message
>>> KrbKdcReq send: kdc=auth.work01.daas.gl.igrupobbva TCP:88, timeout=30000, number of retries =3, #bytes=154
>>> KDCCommunication: kdc=auth.work01.daas.gl.igrupobbva TCP:88, timeout=30000,Attempt =1, #bytes=154
>>>DEBUG: TCPClient reading 685 bytes
>>> KrbKdcReq send: #bytes read=685
>>> KdcAccessibility: remove auth.work01.daas.gl.igrupobbva:88
Looking for keys for: xglkfkdit1w@GL.WORK01.BBVA.COM
Added key: 17version: 2
Found unsupported keytype (18) for xglkfkdit1w@GL.WORK01.BBVA.COM
>>> EType: sun.security.krb5.internal.crypto.Aes128CtsHmacSha1EType
>>> KrbAsRep cons in KrbAsReq.getReply xglkfkdit1w
 
WATCHER::
 
WatchedEvent state:SyncConnected type:None path:null
Found ticket for xglkfkdit1w@GL.WORK01.BBVA.COM to go to krbtgt/GL.WORK01.BBVA.COM@GL.WORK01.BBVA.COM expiring on Thu Sep 20 13:45:19 UTC 2018
Entered Krb5Context.initSecContext with state=STATE_NEW
Found ticket for xglkfkdit1w@GL.WORK01.BBVA.COM to go to krbtgt/GL.WORK01.BBVA.COM@GL.WORK01.BBVA.COM expiring on Thu Sep 20 13:45:19 UTC 2018
Service ticket not found in the subject
>>> Credentials acquireServiceCreds: same realm
Using builtin default etypes for default_tgs_enctypes
default etypes for default_tgs_enctypes: 17 16 23.
>>> CksumType: sun.security.krb5.internal.crypto.RsaMd5CksumType
>>> EType: sun.security.krb5.internal.crypto.Aes128CtsHmacSha1EType
>>> KrbKdcReq send: kdc=auth.work01.daas.gl.igrupobbva TCP:88, timeout=30000, number of retries =3, #bytes=684
>>> KDCCommunication: kdc=auth.work01.daas.gl.igrupobbva TCP:88, timeout=30000,Attempt =1, #bytes=684
>>>DEBUG: TCPClient reading 682 bytes
>>> KrbKdcReq send: #bytes read=682
>>> KdcAccessibility: remove auth.work01.daas.gl.igrupobbva:88
>>> EType: sun.security.krb5.internal.crypto.Aes128CtsHmacSha1EType
>>> KrbApReq: APOptions are 00000000 00000000 00000000 00000000
>>> EType: sun.security.krb5.internal.crypto.Aes128CtsHmacSha1EType
Krb5Context setting mySeqNumber to: 422795367
Krb5Context setting peerSeqNumber to: 0
Created InitSecContextToken:
0000: 01 00 6E 82 02 4F 30 82 02 4B A0 03 02 01 05 A1 ..n..O0..K......
0010: 03 02 01 0E A2 07 03 05 00 00 00 00 00 A3 82 01 ................
0020: 66 61 82 01 62 30 82 01 5E A0 03 02 01 05 A1 14 fa..b0..^.......
0030: 1B 12 47 4C 2E 57 4F 52 4B 30 31 2E 42 42 56 41 ..GL.WORK01.BBVA
0040: 2E 43 4F 4D A2 2E 30 2C A0 03 02 01 00 A1 25 30 .COM..0,......%0
0050: 23 1B 09 7A 6F 6F 6B 65 65 70 65 72 1B 16 7A 6B #..zookeeper..zk
0060: 2D 30 30 30 31 2E 7A 6B 2D 6B 61 66 6B 61 2E 6D -0001.zk-kafka.m
0070: 65 73 6F 73 A3 82 01 0F 30 82 01 0B A0 03 02 01 esos....0.......
0080: 12 A1 03 02 01 02 A2 81 FE 04 81 FB 76 84 72 C8 ............v.r.
0090: 9D 9B 1D AE 66 69 36 77 A2 9F 6C E8 2E 84 4E E3 ....fi6w..l...N.
00A0: 81 AF FF 41 C3 1B 66 B8 BB FD 54 FE 99 3B 67 3C ...A..f...T..;g<
00B0: B5 86 5E 9B 14 84 87 B4 3F F8 7F 46 72 86 8A B5 ..^.....?..Fr...
00C0: F7 2B 1A 23 A1 73 9B 42 C8 EA 48 42 7D 89 CA 83 .+.#.s.B..HB....
00D0: 48 56 65 C1 92 C3 19 CD 03 72 0D C6 6B 2B C0 C9 HVe......r..k+..
00E0: 3F A4 BC E2 0E DE 9B A7 2F A7 23 33 2D AB AB 07 ?......./.#3-...
00F0: FD 12 42 DC 31 6E DD 41 C1 6F DC 1A 1C 5A 24 B2 ..B.1n.A.o...Z$.
0100: A6 73 4B F3 50 81 C2 5A 5C 60 D7 54 86 46 98 7A .sK.P..Z\`.T.F.z
0110: CB 31 00 3E 9A BF DF 4E F0 F4 F7 14 14 1A E0 A2 .1.>...N........
0120: 8E F9 A2 51 67 BC 98 3B AF D6 FB 72 A6 2D 9E 72 ...Qg..;...r.-.r
0130: E8 F5 85 69 73 04 5F D5 60 28 9D EA C4 A0 2B 0A ...is._.`(....+.
0140: 4D A3 85 5C 81 08 0B CD A9 55 7F 02 16 47 B3 21 M..\.....U...G.!
0150: B8 D6 CF 6F CD C3 4B AB A0 2D FC C6 06 BE 5A 74 ...o..K..-....Zt
0160: 00 B0 09 D8 B8 B0 2E 7F 6F E0 4E 4D A8 DA 28 8E ........o.NM..(.
0170: 73 23 F3 E2 3B 76 35 68 E2 3D 16 E2 4A D6 43 13 s#..;v5h.=..J.C.
0180: 0C 41 89 3B FD 66 4C A4 81 CB 30 81 C8 A0 03 02 .A.;.fL...0.....
0190: 01 11 A2 81 C0 04 81 BD 17 6F 25 58 72 A8 04 0A .........o%Xr...
01A0: 77 E3 CF 05 3E 5A D6 61 EB 78 16 3D AA 7C A7 B5 w...>Z.a.x.=....
01B0: DF 8A 7A 1A 5B 38 8B F5 E0 5B D6 1A 1C C5 4C 98 ..z.[8...[....L.
01C0: 3A 68 2A 8F 12 90 F2 FF F3 8F 68 17 BF 64 A9 99 :h*.......h..d..
01D0: 5A AF 42 0B 14 2E 86 FE D9 43 BD 15 F0 0E BA B5 Z.B......C......
01E0: 66 73 65 02 53 C1 C1 6E 4F 6C 32 6A AB 0A EE 7F fse.S..nOl2j....
01F0: AE AE 62 62 13 62 F4 07 E5 AE 99 2E 55 C9 D1 15 ..bb.b......U...
0200: D3 38 21 9E BC 1C 32 DF 64 80 A5 19 C3 35 3D 85 .8!...2.d....5=.
0210: AB 27 66 43 64 28 42 84 42 87 E0 06 F8 05 80 CA .'fCd(B.B.......
0220: 3E 5B C7 23 71 04 B5 56 7A 1E 74 7A 35 DF F9 81 >[.#q..Vz.tz5...
0230: 2C D0 28 11 22 81 85 40 95 D6 09 1D 7D 9C 33 20 ,.(."..@......3
0240: CB 51 22 F3 F3 36 DC 16 38 32 36 30 4E 6A AE 3A .Q"..6..8260Nj.:
0250: B8 A4 AB 4E 97 ...N.
 
Krb5Context.unwrap: token=[05 04 01 ff 00 0c 00 00 00 00 00 00 19 33 58 67 01 01 00 00 1f 3b 5f 33 ba 88 e0 d8 dc aa 1f af ]
Krb5Context.unwrap: data=[01 01 00 00 ]
Krb5Context.wrap: data=[01 01 00 00 78 67 6c 6b 66 6b 64 69 74 31 77 40 47 4c 2e 57 4f 52 4b 30 31 2e 42 42 56 41 2e 43 4f 4d ]
Krb5Context.wrap: token=[05 04 00 ff 00 0c 00 00 00 00 00 00 19 33 58 67 01 01 00 00 78 67 6c 6b 66 6b 64 69 74 31 77 40 47 4c 2e 57 4f 52 4b 30 31 2e 42 42 56 41 2e 43 4f 4d 40 0d f0 df f0 24 d8 0a 90 56 fc 04 ]
 
WATCHER::
 
WatchedEvent state:SaslAuthenticated type:None path:null

Podemos ejecutar diferentes comandos para ver que obtenemos resultados.



ls /
[admin, brokers, cluster, config, consumers, controller, controller_epoch, isr_change_notification, latest_producer_id_block, log_dir_event_notification]
ls /brokers/ids
[0, 1, 2]
get  /brokers/ids/0
{"listener_security_protocol_map":{"SSL":"SSL"},"endpoints":["SSL://kafka-0-broker.kf-shared.mss.work01.daas.es.igrupobbva:9092"],"rack":"TC-I-2","jmx_port":9091,"host":null,"timestamp":"1537365146054","port":-1,"version":4}