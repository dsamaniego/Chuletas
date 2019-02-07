# LDAP

Para conectarse al LDAP a través de la línea de comandos:

Por ejemplo, para consultar un usuario:

Siempre lo hacemos con el usuario Jenkins

ldapsearch -o ldif-wrap=no -ZZ -x -D "cn=jenkins,cn=GlobalWrite,cn=Administrators,cn=Global,dc=bbva,dc=com" -w <contraseña_ldap> -b "dc=bbva,dc=com" "(&(objectClass=posixAccount)(cn=XE78726))" -h <servidor_ldap> -p <puerto> -LLL d

La passowd y la configuración está en vault:
Nos tendremos que conectar a la máquina gosec, exportar el token y leer la siguiente ruta para coger la contraseña:
~~~ bash
vault read /platform/gl/dev/datio/automationsupport/automationsupport/ldap/basic/ldap
~~~

La cadena de conexión la sacamos de:
~~~ bash
[root@gosec2 PLAY01 ~]# vault read /platform/gl/dev/datio/automationsupport/automationsupport/config
Key             	Value
---             	-----
refresh_interval	768h0m0s
config          	tenant=PLAY01;gidDefault=2222222222;iniIdServ=10000;finIdServ=10499;iniIdUser=30000;finIdUser=30999;baseLdap=dc=bbva,dc=com;realm=GL.PLAY01.BBVA.COM;groupDefault=DaasUsers;country=GL;host=ldap.secaas.play.es.ether.igrupobbva;port=389;groupDcosService=manager_admin;groupDcosNominal=DATA_ADM_DCOS;endPointKeytab=v2/keytab;endPointLdap=v2/ldap;endPointCertificate=v2/certificates;NOMBRE_AZ=SVES1P1HdDaaSH3;USUARIO_AZ=uhddaash3;Smartconnect_api=hddaasapi.sces1p100.isi;ISIROOTPATH=/ifs/HD/DaaS/H3;ZoneID=31;vault_path_hdfsls=platform/gl/dev/datio/hdfsls/hdfsls
~~~

Lo que nos interesa el el **host** y el **port**

## NOTA IMPORTANTE
Todavía no se sabe porqué pero hay veces que la clave de jenkins se pierde en el LDAP. La consecuencia es que fallan los jobs de jenkins.

Para comprobar que es por eso, podemos hacer una consulta al ldap (como la anteior), si el problema es por la contraseña, nos dará un error de falta de credenciales.

Para confirmarlo, nos conectamos al Apache Directory Studio, buscamos al usuario jenkins y verificamos la constraseña que hay en vault contra la que tiene almacenada en LDAP, si nos falla la verificación, es que se ha perdido la contraseña, avisamos a Pajo para que nos la restaure.
