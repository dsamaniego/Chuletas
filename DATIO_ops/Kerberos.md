# Operativas de Kerberos.

## Kerberizar un usuario.
1. Nos conectamos al gosec y sacamos el token del usuario.
```
[root@gosec2.live01 ~]# vault read userland/serviceusers/xd-rskc-sandbox
Key             	Value
---             	-----
refresh_interval	768h0m0s
password        	A6Vr1PJybQJulLxl
userCN          	xglxdrskc1l
username        	cn=xglxdrskc1l,ou=ServiceUsers,cn=LIVE01,cn=Tenant,c=gl,dc=bbva,dc=com

[root@gosec2.live01 ~]# vault read userland/serviceusers/xd-rskc-sandbox
Key             	Value
---             	-----
refresh_interval	768h0m0s
password        	A6Vr1PJybQJulLxl
userCN          	xglxdrskc1l
username        	cn=xglxdrskc1l,ou=ServiceUsers,cn=LIVE01,cn=Tenant,c=gl,dc=bbva,dc=com

[root@gosec2.live01 ~]# vault read userland/serviceusers/xd-rskc-sandbox
Key             	Value
---             	-----
refresh_interval	768h0m0s
password        	A6Vr1PJybQJulLxl
userCN          	xglxdrskc1l
username        	cn=xglxdrskc1l,ou=ServiceUsers,cn=LIVE01,cn=Tenant,c=gl,dc=bbva,dc=com

[root@gosec2.live01 ~]# vault read userland/serviceusers/xd-rskc-sandbox
Key             	Value
---             	-----
refresh_interval	768h0m0s
password        	A6Vr1PJybQJulLxl
userCN          	xglxdrskc1l
username        	cn=xglxdrskc1l,ou=ServiceUsers,cn=LIVE01,cn=Tenant,c=gl,dc=bbva,dc=com

[root@gosec2.live01 ~]# vault read userland/serviceusers/xd-rskc-sandbox
Key             	Value
---             	-----
refresh_interval	768h0m0s
password        	A6Vr1PJybQJulLxl
userCN          	xglxdrskc1l
username        	cn=xglxdrskc1l,ou=ServiceUsers,cn=LIVE01,cn=Tenant,c=gl,dc=bbva,dc=com

[root@gosec2.live01 ~]# vault read userland/serviceusers/xd-rskc-sandbox
Key             	Value
---             	-----
refresh_interval	768h0m0s
password        	A6Vr1PJybQJulLxl
userCN          	xglxdrskc1l
username        	cn=xglxdrskc1l,ou=ServiceUsers,cn=LIVE01,cn=Tenant,c=gl,dc=bbva,dc=com

```
2. Nos conectamos a la máquina cliente de HDFS y kerberizamos el usuario:
```
> echo "XXXXX" | base64 -d > <usuario_servicio>.keytab
> kinit -kt <usuario_servicio>.keytab <usuario_servicio>
```

