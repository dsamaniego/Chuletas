# Openstack

## Conexión
Para conectarnos a openstack de un entorno...

Nos conectamos a id2 por ssh y ahí nos conectamos al contenedor que esté ejecutando el ilúvatar.

[cloud-user@id2 ~]$ docker ps
CONTAINER ID        IMAGE                                                                                          COMMAND                  CREATED             STATUS              PORTS               NAMES
9f4b2a995344        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.4.3-upgrade          "/datio/iluvatar/entr"   2 hours ago         Up 2 hours                              form01
dd4f16233bed        nexus.daas.work.es.ether.igrupobbva/repository/es-draft/datio/iluvatar:sebas-update-SNAPSHOT   "/datio/iluvatar/entr"   5 hours ago         Up 5 hours                              daas-es-dev-05-sebasshtian
93ed75bdf910        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/groot:1.0.0                     "/bin/bash"              34 hours ago        Up 34 hours                             prickly_knuth
f6c342cdcb4a        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/groot:1.0.0                     "/bin/bash"              34 hours ago        Up 34 hours                             naughty_goldstine
08cce462304c        15a9f1005b0a                                                                                   "/bin/bash"              2 days ago          Up 2 days                               condescending_shaw
8cfd4ea0839f        46c6a343d90b                                                                                   "/bin/bash"              2 days ago          Up 2 days                               stupefied_lumiere
5fd35c4dfa8c        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.1                  "/datio/iluvatar/entr"   4 days ago          Up 4 days                               sharp_engelbart9
c2d3bb2e4f61        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.1                  "/datio/iluvatar/entr"   5 days ago          Up 5 days                               amazing_ptolemy
1477e342bb71        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.1                  "/datio/iluvatar/entr"   6 days ago          Up 6 days                               hungry_euler
f459d0966fd0        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.1                  "/datio/iluvatar/entr"   7 days ago          Up 7 days                               mad_ride
abaa5cf72348        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.9                  "/datio/iluvatar/entr"   8 days ago          Up 8 days                               priv02-v2.5.9
1bcbf9afc7f5        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.1                  "/datio/iluvatar/entr"   11 days ago         Up 11 days                              cocky_williams
1f3638e0da2e        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.1                  "/datio/iluvatar/entr"   12 days ago         Up 12 days                              grave_wozniak
874bb9235afa        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.1                  "/datio/iluvatar/entr"   13 days ago         Up 13 days                              mad_wright
131da88a588c        b2f29d81880a                                                                                   "/bin/bash"              2 weeks ago         Up 2 weeks                              goofy_ardinghelli
d0d85d298b4f        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.1                  "/datio/iluvatar/entr"   2 weeks ago         Up 2 weeks                              dreamy_bassi
aec1cb3b6484        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.1                  "/datio/iluvatar/entr"   2 weeks ago         Up 2 weeks                              adoring_lovelace
278e99bfd06d        f53b4fd3348c                                                                                   "/bin/bash"              3 weeks ago         Up 3 weeks                              tender_jang
fe45caba8500        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.1                  "/datio/iluvatar/entr"   3 weeks ago         Up 3 weeks                              focused_easley
09ac0c45c665        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:OSCtest                "/datio/iluvatar/entr"   3 weeks ago         Up 3 weeks                              priv02-OSCtest
8ca3c2b58726        e045bdeee6bc                                                                                   "/bin/bash"              3 weeks ago         Up 3 weeks                              jovial_khorana
e834f9e7050a        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.1                  "/datio/iluvatar/entr"   3 weeks ago         Up 3 weeks                              silly_wescoff
5eea94382e75        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:devel                  "/datio/iluvatar/entr"   3 weeks ago         Up 3 weeks                              play-prod-pe-test
c845e254e39d        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.1                  "/datio/iluvatar/entr"   3 weeks ago         Up 3 weeks                              tender_goodall
375e326221ce        43c730dfc0c1                                                                                   "/bin/bash"              3 weeks ago         Up 3 weeks                              grave_elion
6c2460536e03        e9998bf6b82d                                                                                   "/bin/bash"              3 weeks ago         Up 3 weeks                              desperate_heyrovsky
8ca74659e504        ce094b4303f0                                                                                   "/bin/bash"              3 weeks ago         Up 3 weeks                              tiny_hypatia
8df3840e7c25        5a982e467042                                                                                   "/bin/bash"              4 weeks ago         Up 4 weeks                              nostalgic_ptolemy
99cd0d6a7583        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:test-millaguie         "/datio/iluvatar/entr"   4 weeks ago         Up 4 weeks                              play-millaguie-gerrit
688b8ce2d938        23dfa7f41c7c                                                                                   "/datio/iluvatar/entr"   4 weeks ago         Up 4 weeks                              priv01-eos22
613f063cfe22        ac669e7a91fa                                                                                   "/bin/bash"              4 weeks ago         Up 4 weeks                              awesome_einstein
12cf6d12dd4a        c3d310a8819f                                                                                   "/bin/bash"              4 weeks ago         Up 4 weeks                              insane_keller
4487b33fd854        153787dfab72                                                                                   "/bin/bash"              5 weeks ago         Up 5 weeks                              prickly_mcclintock
b401d9f3cf93        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:luaproxy_keytab        "/datio/iluvatar/entr"   5 weeks ago         Up 5 weeks                              dev05-luaproxy-keytab
7114614b0fbc        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.9                  "/datio/iluvatar/entr"   6 weeks ago         Up 6 weeks                              priv01-calico
975852446e53        3b08f3ffcfce                                                                                   "/bin/bash"              6 weeks ago         Up 6 weeks                              drunk_swanson
8f37009565ad        81e3ad98d2a6                                                                                   "/datio/iluvatar/entr"   6 weeks ago         Up 6 weeks                              priv01-pe-athens-lb
642ae052a772        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/groot:1.0.0                     "/bin/bash"              6 weeks ago         Up 6 weeks                              pedantic_cori
61e9180dcf30        5e5111f26ee9                                                                                   "/bin/bash"              6 weeks ago         Up 6 weeks                              elated_keller
35d794b818fb        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/groot:1.0.0                     "/bin/bash"              6 weeks ago         Up 6 weeks                              goofy_borg
179035e481e7        318a991b5141                                                                                   "/bin/bash"              7 weeks ago         Up 7 weeks                              desperate_pike
bbe9f4097312        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.3.4                  "/datio/iluvatar/entr"   7 weeks ago         Up 21 minutes                           dev02-update
ab90330afdae        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.9                  "/datio/iluvatar/entr"   7 weeks ago         Up 3 weeks                              workes-2.5.9
df6960026f22        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.9                  "/datio/iluvatar/entr"   7 weeks ago         Up 11 minutes                           workgl
34657bd3e584        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.9                  "/datio/iluvatar/entr"   7 weeks ago         Up 20 minutes                           play
db73fee59fd7        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.8                  "/datio/iluvatar/entr"   7 weeks ago         Up 4 weeks                              workgl-2.5.8
8cdf7a09697d        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:NoLbaas                "/datio/iluvatar/entr"   8 weeks ago         Up 8 weeks                              compassionate_borg
f07ec4d40d6c        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.8                  "/datio/iluvatar/entr"   8 weeks ago         Up 12 minutes                           workes
35de7d21d813        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.8                  "/datio/iluvatar/entr"   8 weeks ago         Up 5 weeks                              play-2.5.8
4b88d148e05f        81e3ad98d2a6                                                                                   "/datio/iluvatar/entr"   9 weeks ago         Up 9 weeks                              cocky_archimedes
fe862a6abdef        81e3ad98d2a6                                                                                   "/datio/iluvatar/entr"   9 weeks ago         Up 9 weeks                              suspicious_knuth
e7ba1b50f418        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.6                  "/datio/iluvatar/entr"   9 weeks ago         Up 9 weeks                              workes-2.5.6
42e59751a11b        54bd938f04f0                                                                                   "/datio/iluvatar/entr"   11 weeks ago        Up 11 weeks                             naughty_khorana
e873c18a2c88        d845fa5c22c5                                                                                   "/datio/iluvatar/entr"   11 weeks ago        Up 11 weeks                             sick_keller
fe90878d15ee        d845fa5c22c5                                                                                   "/datio/iluvatar/entr"   11 weeks ago        Up 11 weeks                             clever_meninsky
fc4bfc0496c1        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.3-RC1              "/datio/iluvatar/entr"   12 weeks ago        Up 16 minutes                           priv02
bbd4edcb3a42        5d86ed404993                                                                                   "/datio/iluvatar/entr"   3 months ago        Up 3 months                             high_hawking
af1a8556ecf4        5d86ed404993                                                                                   "/datio/iluvatar/entr"   3 months ago        Up 3 months                             berserk_swanson
8d794ace8f87        6844242006a6                                                                                   "/datio/iluvatar/entr"   3 months ago        Up 3 months                             admiring_jennings
[cloud-user@id2 ~]$ docker ps|grep workes
ab90330afdae        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.9                  "/datio/iluvatar/entr"   7 weeks ago         Up 3 weeks                              workes-2.5.9
f07ec4d40d6c        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.8                  "/datio/iluvatar/entr"   8 weeks ago         Up 13 minutes                           workes
e7ba1b50f418        nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/iluvatar:2.5.6                  "/datio/iluvatar/entr"   9 weeks ago         Up 9 weeks                              workes-2.5.6
[cloud-user@id2 ~]$ docker exec -it f07ec4d40d6c bash

[root@daas-global-work-01 iluvatar]# source entrypoint.sh 
LANG=C.UTF-8
OS_AUTH_URL=https://rdlj2jvgawkf9m.api.es.iaas.igrupobbva/v2.0
HOSTNAME=df6960026f22
ENVIRONMENT_TYPE=DEV
ANSIBLE_VERSION=2.5.5
GPG_KEY=C01E1CAD5EA2C4F0B8E3571504C367C218ADD4FF
PYTHONIOENCODING=UTF-8
SSH_AUTH_SOCK=/tmp/root-ssh-socket
USER=root
PWD=/datio/iluvatar
HOME=/root
IVT_CONFIG=/environment/descriptors/descriptor.json
OS_TENANT_NAME=daas-global-work-01
TERM=xterm
PYTHONWARNINGS=ignore
TERRAFORM_VERSION=0.10.8
PYTHON_VERSION=2.7.15
SHLVL=1
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
OS_PASSWORD=fZ8Peef61dUHNZWX
PS1=\[\e[1;34m\][\u@daas-global-work-01 \W]\$\[\e[0m\] 
OS_USERNAME=user_daas-global-work-01
PYTHON_PIP_VERSION=18.1
_=/usr/bin/printenv
[root@daas-global-work-01 iluvatar]# openstack server list |grep "agent-44|agent-41|agent-47|monitoring-data-2"
[root@daas-global-work-01 iluvatar]# openstack server list |egrep "agent-44|agent-41|agent-47|monitoring-data-2"
| 70df8afb-6ea5-4e86-8bd6-d5ad83cc647d | agent-47            | SHUTOFF | net_internal=192.168.192.64; STORAGE_PROVIDER=10.48.65.166             | RHEL7.3 | b1.large  |
| 0a1f471a-2a36-40ab-b057-5087220c9ce7 | agent-41            | SHUTOFF | net_internal=192.168.192.69; STORAGE_PROVIDER=10.48.66.108             | RHEL7.3 | b1.large  |
| a8474001-c968-479a-941a-62de1b3e0a5b | agent-44            | SHUTOFF | net_internal=192.168.192.70; STORAGE_PROVIDER=10.48.66.111             | RHEL7.3 | b1.large  |
| 4d2d2f35-2c7b-44bb-a19f-1b3120d2b9cf | monitoring-data-2   | SHUTOFF | net_infra=192.168.102.24                                               | RHEL7.3 | b1.large  |
[root@daas-global-work-01 iluvatar]# 

### Tennants id2
Hay un contenedor (como root): (buscar con ctrl+r groot)
docker run --rm -e OS_TENANT_NAME=DaaS_Es_DEV_01  -e OS_PASSWORD="BRr6+TpeviBzrXOG"  -e OS_AUTH_URL=https://rdlj2jvgawkf9m.api.es.iaas.igrupobbva/v2.0 -e OS_USERNAME=user_DaaS_Es_DEV_01 -ti -v /data:/data --entrypoint=/bin/bash nexus.daas.work.es.ether.igrupobbva/repository/es-docker/datio/groot:1.0.0

## Algunos comandos útiles.

### Sacar las máquinas de una zona de disponiblidad
``` bash
 openstack server list --long | grep "TC-I-3" | awk '{print $4 }' | grep -v "agent-f"
```
