# Certificados

## Procedimiento para la renovación de certificados

Tiene que ser la versión de eos 0.12.20 y desde el bootstrap que tenga /stratio_volume y tenéis que verlo como una intervención porque puede tener pérdida de servicio en principio si funciona bien tarda 15 min.

1. Comprobar las siguientes rutas de vault y comprobar que esá bien los usuarios:
    * `vault read gosec/passwords/sso/ldap` (el usuario tiene que ser **gosec-sso**)
    * `vault read gosec/kerberos/kafka` (el usuario tiene que ser **gosec-kafka**)
2. Levantar el docker de stratio desde bootstrap del entorno

    ~~~ bash
    jhicar@jhicar:~$ id2
    Last login: Thu Jan 24 18:11:27 2019 from 10.51.66.68

    Everytime a docker without --rm is launched a God kills a kitten
    [root@daas-es-dev-03 iluvatar]# cd deployer/ansible/
    [root@daas-es-dev-03 ansible]# ssh -F ssh_config bootstrap-1
    Warning: Permanently added '10.48.226.145' (ECDSA) to the list of known hosts.
    Last login: Thu Jan 24 15:09:20 2019 from 192.168.102.19
    [cloud-user@bootstrap-1 PLAY01 ~]$ sudo su -
    Last login: Thu Jan 24 15:09:22 UTC 2019 on pts/0
    [root@bootstrap-1 PLAY01 ~]# docker run --rm -ti --name paas-bootstrap --shm-size 2G \
    -v /stratio_volume:/stratio_volume -v /var/run/docker.sock:/var/run/docker.sock  \
    -e HOST_IP=192.168.102.29   -p 8888:8888 -p 8080:8080 -p 8081:8081 -p 80:80  \ nexus.daas.work.es.ether.igrupobbva/repository/es-docker/stratio/eos-installer:0.12.20 bash
    ~~~

3. Comprobar que existe el script **checkcerts.py** en ```/stratio_volume/```
4. Lanzar:

    ~~~ bash
    python checkcerts.py https://vault.service.eos.$(jq -r .dnsSearch descriptor.json):8200 $(jq -r .root_token vault_response) /dcs
    ~~~

5. Lanzar: 

    ~~~ bash
    dcos-deployer securize-cluster --kerberos_principal datioDeployer/admin --renewal_secrets --tags renewal-certificates
    ~~~

6. Pasar el rol **fix-master**

    ~~~ bash
    ansible-playbook datio.yml -t fix-master
    ~~~

En general, el docker de stratio se levanta con:

~~~ bash
docker run --rm -ti --name paas-bootstrap --shm-size 2G \
-v /stratio_volume:/stratio_volume -v /var/run/docker.sock:/var/run/docker.sock \
-e HOST_IP=<net_infra_bootstrap_ip> \
-p 8888:8888 -p 8080:8080 -p 8081:8081 -p 80:80 \
<nexus_url>/stratio/eos-installer:<eos_version> bash
~~~