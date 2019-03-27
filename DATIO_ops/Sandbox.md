# Sandbox

## Grupos de Sandbox Manager

Se pueden ver en el descriptor del Sandbox-api (etiqueta: "SUPERUSER_GROUP")

* Live-ES: DATP_ADM_SBX
* Live-GL: DAGP_ADM_SBX

Para acceder al sandbox de un proyecto específico vale con dar el permiso: DA<CCE>_US_<UUAA>4

## Process Manager.

Los datos los saca de la base de datos **pgsandbox**, la conexión:

~~~sql
root@agent-f1-16:/# psql -Usandbox -p$PORT0 
psql (9.6.8)
Type "help" for help.

sandbox=> \c sandbox
You are now connected to database "sandbox" as user "sandbox".
sandbox=> set search_path to sandbox;
SET
~~~

A partir de aquí ya sacamos las consultas que queramos

### Alguna cosulta interesante

* Sacar el grupo del sandbox:  
	`select * from groups where id=(select id from sandbox where name like '<UUAA>');`
* Sacar los Frameworks id de jobs:  
	`select e.history_server_id from execution e inner join version v on v.id = e.version_id where v.job_name like '%nombre_job%';`
