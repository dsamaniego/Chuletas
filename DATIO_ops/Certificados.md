# Certificados.

## Procedimiento para la renovación de certificados.

Tiene que ser la versión de eos 0.12.20 y desde el bootstrap que tenga /stratio_volume y tenéis que verlo como una intervención porque puede tener pérdida de servicio en principio si funciona bien tarda 15 min.

1. Levantar el docker de stratio desde bootstrap del entorno

    ~~~ bash
    jhicar@jhicar:~$ id2
    Last login: Thu Jan 24 18:11:27 2019 from 10.51.66.68

    Everytime a docker without --rm is launched a God kills a kitten
    root@daas-es-dev-03 iluvatar]# cd deployer/ansible/
    [root@daas-es-dev-03 ansible]# ssh -F ssh_config bootstrap-1
    Warning: Permanently added '10.48.226.145' (ECDSA) to the list of known hosts.
    Last login: Thu Jan 24 15:09:20 2019 from 192.168.102.19
    [cloud-user@bootstrap-1 PLAY01 ~]$ sudo su -
    Last login: Thu Jan 24 15:09:22 UTC 2019 on pts/0
    [root@bootstrap-1 PLAY01 ~]# docker run --rm -ti --name paas-bootstrap --shm-size 2G \
    -v /stratio_volume:/stratio_volume -v /var/run/docker.sock:/var/run/docker.sock  \
    -e HOST_IP=192.168.102.29   -p 8888:8888 -p 8080:8080 -p 8081:8081 -p 80:80  \ nexus.daas.work.es.ether.igrupobbva/repository/es-docker/stratio/eos-installer:0.12.20 bash
    ~~~

2. Comprobar que existe el script **checkcerts.py**
3. Lanzar: ```./checkcerts.py urlvaultconpuerto token /rutadevault```
4. Lanzar: ```dcos-deployer securize-cluster --kerberos_principal datioDeployer/admin --renewal_secrets --tags renewal-certificates``` 
5. Pasar el rol **fix-master**

En general, el docker de stratio se levanta con:

~~~ bash
docker run --rm -ti --name paas-bootstrap --shm-size 2G \
-v /stratio_volume:/stratio_volume -v /var/run/docker.sock:/var/run/docker.sock \
-e HOST_IP=<net_infra_bootstrap_ip> \
-p 8888:8888 -p 8080:8080 -p 8081:8081 -p 80:80 \
<nexus_url>/stratio/eos-installer:<eos_version> bash
~~~
