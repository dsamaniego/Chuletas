Nos viene a las 19:00 Jesús a decirnos que XData de FUJUR no funciona (live.es)

Me meto en el DC/OS y ve que el xd-kdco-sandbox está levantado, pero en los logs veo lo siguiente:
2018-11-29T17:53:56.640Z ERROR HB_89088420-e6b0-40e3-ae08-9ebcd01250ab 0 scala com.stratio.crossdata.server.actors.ServerActor$$anonfun$eventsRec$1 {"@timestamp":"2018-11-29T17:53:56.640Z","@message":"Spark Job failed: Operation not authorized","@data":{}}

-- Este log lo suele poner siempre (funcione o no)

Para ver el grupo, lo mejor meterse en el descriptor del XDATA y ahí se ve cual es el grupo.

Además, se puede hacer el test que se hace cuando se despliega el xdata. (https://datiobd.atlassian.net/wiki/spaces/OP/pages/640352269/Despliegue+Crossdata+2.11.1-0.13.2)

Para probar que está funcionando correctamente podemos subir una tabla de prueba a HDFS y luego crear una tabla en crossdata y hacer una consulta.

1.- Subimos fichero prueba: CITY_CTR_SLS-parquet.tar.gz
2.- Obtenemos el keytab del usuario de servicio de crossdata y lo guardamos en el cliente HDFS del entorno. (conectados a gosec)
    ```vault read userland/kerberos/xd-doip-sandbox```
3.- Accedemos a cliente HDFS y guardamos le keytab: ```echo "XXXXX" | base64 -d > <usuario_servicio>.keytab```
4.- Subimos el fichero de prueba al cliente HDFS, para ello lo subiremos a Nexus y descargaremos desde el cliente.
```
$ wget https://nexus.daas.live.es.ether.igrupobbva/repository/things/TEST-CROSSDATA/CITY_CTR_SLS-parquet.tar.gz
$ tar -zxvf CITY_CTR_SLS-parquet.tar.gz
$ kinit -kt <usuario_servicio>.keytab <usuario_servicio>
$ hdfs dfs -put CITY_CTR_SLS-parquet /data/sandboxes/XXXX/xdata
```
5.- Accedemos al agente donde está corriendo crossdata y nos conectamos al docker. Una vez dentro ejecutamos:
```
cd /opt/sds/crossdata/bin
./crossdata-shell --user xesxddoip1l --host xd-doip-sandbox.marathon.l4lb.live02.daas.es.igrupobbva:443
```
    - Probamos que podemos mostrar las tablas
    ```
    show databases
    use PUBLIC
    show tables
    ```
    - Creamos una tabla de prueba y la consultamos:
    ```
    CREATE TABLE city USING parquet OPTIONS (path '/data/sandboxes/XXXX/xdata/CITY_CTR_SLS-parquet')
    select * from city limit 10;
    ```

Si queremos recolectar datos, tendremos que conectarnos al mesos y en mesos-framework buscar el framework que levanta el servicio, para ver qué cluster levanta (las máquinas en las que se distribuye, y poder recoger logs o lo que sea).

