# Desescalado de PLAY
seguir la intervención en directo:
~~~ bash
ssh id2
docker logs --tail 10 -f play
~~~

## Procedimiento:
1. Backup de los postgres: Nos vamos al bootstrap-1 y ejecutamos el dumpPG.sh
2. Borrar los agentes del 26 al 42, hay que ir poniéndolos en mantenimiento en grupos de unos cuantos agentes (para que se muevan los servicios que haya corriendo en ellos a otros agentes).
    - Nos vamos al master de mesos que está haciendo de leader y desde ahí:
        * Ponemos en mantenimiento los nodos: `./downscale.py --maintenance -a agent-35-42`, lo que hará que no entren mas servicios a esos nodos y los que tienen los pasan a otros.
        * Paramos los nodos: `./downscale.py --down -a 35-42`
3. Borrar los agentes que se han ido poniendo en mantenimiento.
4. Editar el descriptor para que en vez de 42 agentes privados haya 25
     - Primero lanzamos el plan de terraform para comprobar que realmente sólo va a borrar lo que queremos: 
        `python -m iluvatar -c -p`
    el _datio.yml_ esta renombrado para que cuando termine terraform se corte y no siga con ansible       
5. Lanzar el playbook `ansible playbook playbooks/scale.yml`