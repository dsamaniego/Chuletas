# Comandos ISILON

## Comandos Usuario AZ

### Consulta de ACLs
~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi_run -z ZoneID sudo /bin/ls -lead Root_path/directorio
~~~

### Creación de ACLs.

~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi_run -z ZoneID sudo /bin/chmod +a group NOMBRE GRUPO allow PERMISOS NECESARIOS Root_path/directorio
~~~

#### Permisos

* dir_gen_all: Permisos para realizar cualquier tipo de accion en el directorio. UNICAMENTE se debe de aplicar al grupo al que pertenece el usuario de las ACLs.
* traverse: Se aplica siempre a everyone y sirve para que todos los usuarios puedan atravesar todos los dirtectorios.
* dir_gen_read:  Permite al usuario leer ficheros y directorios.
* dir_gen_write, delete_child: El conjunto de estos permisos siempre es necesario que se aplique si queremos dar permisos de escritura. (W)
* dir_gen_execute: Permite al usuario ejecutar ficheros y atravesar directorios. (X)
* object_inherit,container_inherit: Estos permisos son los más importantes de todos. Su conjunto implica que cualquier objeto que se cree por debajo va a heredar los permisos del directorio padre.

Cualquier otro permiso no está contemplado y no se utiliza en ninguno de los entornos.

### Borrado de ACLs

~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi_run -z ZoneID sudo /bin/chmod -a POSICION_ACL Root_path/directorio
~~~

### Consulta de directorios

~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi_run -z ZoneID sudo /bin/ls -l Root_path/directorio
~~~

### Lanzado del Job de recursividad

MUCHO CUIDADO CON LOS PATH QUE INDICAMOS... Se aplicará recursivamente.

~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi job jobs start PermissionRepair --paths=Root_path/directorio --template=Root_path/directorio --mode=inherit
~~~

### Lectura de ficheros.

~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /bin/cat Root_path/in/staging/ratransmit/host/guido/*
~~~

### Creación de directorios

~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /bin/mkdir -p Root_path/directorio
~~~

### Borrado de directorios

~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /bin/rm -Rf Root_path/directorio

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /bin/rmdir -p Root_path/directorio

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /bin/rmdir Root_path/directorio
~~~

### Consulta usuarios LDAP

~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi auth users view USUARIO --zone=Nombre_AZ

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi_run -z ZoneID sudo /usr/bin/id USUARIO
~~~

### Consulta estado JOB

~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi job jobs view --job=JOB_ID
~~~

### Creación exports

#### Intelligence

~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi nfs exports create --all-dirs=true --map-root=nobody:GRUPO1 --map-non-root=nobody:GRUPO2 --paths=Root_path/intelligence/in<XXXX> --security-flavors=krb5p --zone=Nombre_AZ
~~~

* GRUPO 1: el de KDIT (DAXXX_SE_KDIT)
* GRUPO 2: el de data scientist  (DAXXX_US_XXXX4) 

Para comprobar usar el comando `showmount -e <smartconnect>`

Los export genéricos se deben solicitar abriendo una petición a Iaas Storage en el siguiente enlace:
[https://globaldevtools.bbva.com/jira/servicedesk/customer/portal/14#]

##### Ejemplo

Export de **/in/staging** en WORK ES con seguridad kerberos
AZ: SVES1P1ESDaaSDEV
Path: /ifs/ES/DaaS/DEV/in/staging
Seguridad: krb5p
Mount de export:  
`mount -t nfs4 -o sec=krb5p <SmartConnect>:<RootPath>/intelligence/<intelligence> /mnt/tmp`

### Chequeo de exports

Primero hacemos un listado de los exports del entorno y después consultamos con el ID.

~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi nfs exports list --zone=Nombre_AZ
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi nfs exports view ID --zone=Nombre_AZ
~~~

##### Ejemplo para WORK GL

~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false ugldaasde@hddaasapi.sces1p100.isi sudo /usr/bin/isi nfs exports list --zone=SVES1P1GLDaaSDEV
Warning: Permanently added 'hddaasapi.sces1p100.isi,10.48.64.51' (ECDSA) to the list of known hosts.
Password:
ID Zone Paths Description
-----------------------------------------------------------------------------------------------------------------------------------
1 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/intelligence/inrisk Export NFS Intelligence de zona Global DEV
2 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/intelligence/incibo Export NFS intelligence de zona Global DEV
3 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/intelligence/inup18 INUP18
4 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/in/staging/ratransmit Share para APX
5 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/out/staging/ratransmit Share para APX
10 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/intelligence/inarin -
11 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/data/raw/kdar/data/portfoliomanagement/provisions Pruebas NFS
12 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/in/staging/semaas/ebgc File System solicitado por SemaaS
13 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/backup DEV Backup
14 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/prueba_semaas Share solicitado por DATIO
15 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/intelligence/inform Inform export
28 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/intelligence/invbox -
30 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/intelligence/intest -
31 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/in/staging -
37 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/intelligence/inLIME -
43 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/intelligence/inlime -
47 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/intelligence/inmxdm -
50 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/intelligence/inpani -
51 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/intelligence/indday -
52 SVES1P1GLDaaSDEV /ifs/GL/DaaS/DEV/intelligence -
-----------------------------------------------------------------------------------------------------------------------------------
Total: 20
~~~

~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false ugldaasde@hddaasapi.sces1p100.isi sudo /usr/bin/isi nfs exports view 15 --zone=SVES1P1GLDaaSDEV
Warning: Permanently added 'hddaasapi.sces1p100.isi,10.48.64.50' (ECDSA) to the list of known hosts.
Password:
                     ID: 15
                   Zone: SVES1P1GLDaaSDEV
                  Paths: /ifs/GL/DaaS/DEV/intelligence/inform
            Description: Inform export
                Clients: -
           Root Clients: -
      Read Only Clients: -
     Read Write Clients: -
               All Dirs: Yes
             Block Size: 8.0k
           Can Set Time: Yes
       Case Insensitive: No
        Case Preserving: Yes
       Chown Restricted: No
    Commit Asynchronous: No
Directory Transfer Size: 128.0k
               Encoding: DEFAULT
               Link Max: 32767
         Map Lookup UID: No
              Map Retry: Yes
               Map Root
                    Enabled: True
                       User: nobody
              Primary Group: DAGD_SE_KDIT
           Secondary Groups: -
           Map Non Root
                    Enabled: True
                       User: nobody
              Primary Group: DAGD_US_FORM4
           Secondary Groups: -
            Map Failure
~~~

### Flush users

Hay que hacer un ping a Smartconnect_api para saber qué pool de IPs lo componen. Una vez tengamos identificadas las IPs hay que lanzar el comando para cada una de las IPs.

~~~ bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@IP_Smartconnect_api  sudo /usr/bin/isi auth users flush
~~~


- Flush groups.

Hay que hacer un ping a Smartconnect_api para saber qué pool de IPs lo componen. Una vez tengamos identificadas las IPs hay que lanzar el comando para cada una de las IPs.

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo  /usr/bin/isi auth groups flush



- Flush cache.

Hay que hacer un ping a Smartconnect_api para saber qué pool de IPs lo componen. Una vez tengamos identificadas las IPs hay que lanzar el comando para cada una de las IPs.

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi auth cache flush --all --zone=Nombre_AZ



- Refresh exports.

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi nfs exports reload --zone=Nombre_AZ





Comandos Usuario UMONQT:

- Listar cuota disco (disk quote)

ssh -i clave -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false <USER_CUOTAS>@Smartconnect_api sudo /usr/bin/isi quota list

ssh -i clave -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false <USER_CUOTAS>@Smartconnect_api sudo /usr/bin/isi quota quotas view * --type=directory



Comandos Usuario SAND:



- Consulta de directorios.

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api /bin/ls -l Root_path/directorio

- Consulta de atributos.

/usr/sbin/lsextattr * /Root_path/directorio

- Set de atributos.

/usr/sbin/setextattr * * * /Root_path/directorio

- Obtencion de atributos.

/usr/sbin/getextattr * * /Root_path/directorio

- Borrado de atributos.

/usr/sbin/rmextattr * * /Root_path/directorio

- Borrado de directorios.

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /bin/rm -Rf Root_path/directorio

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /bin/rmdir -p Root_path/directorio

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /bin/rmdir Root_path/directorio

- Creación de directorios.

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /bin/mkdir -p Root_path/directorio

- Creación exports

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi nfs exports create --all-dirs=true --map-root=nobody:GRUPO1 --map-non-root=nobody:GRUPO2 --paths=Root_path/intelligence/<nombre intelligence> --security-flavors=krb5p --zone=Nombre_AZ

- Cut

/usr/bin/cut *, \

- Listar cuota disco (disk quote)

ssh -i clave -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=false USUARIO_AZ@Smartconnect_api sudo /usr/bin/isi quota list --path=Root_path/directorio

-Establecer quotas

usr/bin/isi quota quotas create Root_path/directorio directory --hard-threshold=SIZE --include_snapshots=false --thresholds_include_overhead=false --enforced=true

- Borrar quotas

/usr/bin/isi quota quotas Root_path/directorio directory -include_snapshots=false --force

- Modificar quotas

/usr/bin/isi quota quotas modify Root_path/directorio directory --hard-threshold=Size --include_snapshots=false --thresholds_include_overhead=false --enforced=true

- Curls

/usr/local/bin/curl * /namespace/ifs/<HD|ES|GL>/DaaS/<H3|H2|DEV|LIVE|PRO|PRIV|PRIV02|QA|POC>/, \

/usr/local/bin/curl * */session/1/session, \