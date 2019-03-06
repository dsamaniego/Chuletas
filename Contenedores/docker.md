# Comandos útiles en Docker

## Sacar información de imágenes de docker

~~~ bash
for image in $(docker images -q ); do docker inspect $image | jq -r 'map([.<campo1>,..., .<campoN>])'; done 
~~~

Explicación:
- `docker images -q`: saca los IDs de las imágenes de docker
- `docker inspect <id_imagen>`: Saca los metadatos de la imagen
- `jq -r 'map([.<campo1>,...,.<campoN>])'`

Para saber los campos, primero tendríamos que hacer el _docker inspect_ de una de las imágenes para ver los campos que hay.

## Limpieza de espacio

* remove exited containers:  
`docker ps --filter status=dead --filter status=exited -aq | xargs -r docker rm -v`
* remove exited containers:  
`docker ps --filter status=dead --filter status=exited -aq | xargs -r docker rm -v`
* remove unused images:  
`docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi`
* remove unused volumes:  
`find '/var/lib/docker/volumes/' -mindepth 1 -maxdepth 1 -type d | grep -vFf <( docker ps -aq | xargs docker inspect | jq -r '.[] | .Mounts | .[] | .Name | select(.)') | xargs -r rm -fr`
