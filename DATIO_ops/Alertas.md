# Alertas.

Tengo el repositorio en /home/jhicar/Repos/argos
Las condiciones para que salten las alertas en **monitoring-kibana-1**, carpeta ```/usr/share/elastalert/real_rules/```

## hdfsclient sin espacio en /
Revisar los ```/home``` de los usuarios que suelen dejar ficheros grandes en sus directorios de trabajo. En teoría, estos directorios serían para que dejasen ahí cosas que van a usar en sus ingestas, pero que tienen que pasar al Isilon, y sólo deberían estar ahí temporalmente.

Lo mismo sería una buena idea tener un job que hiciese un barrido de esos directorios y hacer limpieza.

Hablarlo con Iago, en principio, todo lo que exceda de 3M no debe de estar en /home mas de 15 días.

## No hay espacio para las persisencias.
En cada entorno hay definido un espacio que tienen que usar los contenedores para dejar sus datos: está en /storage, es común a todos los agentes porque un docker cae en un contenedor y luego puede caer en otro distinto.

Para ver las persistencias usaremos el siguiente comando:
```
curl http://leader.mesos:5050/slaves| jq '.slaves[] | select(.hostname == "ip") '
```
Donde la ip será la del agente que está ejecutando el proceso.¿?
Nos va a devolver algo del estilo:
```
<aquí metemos el json que devuevle.>
```