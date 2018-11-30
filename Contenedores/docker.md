#Sacar información de imágenes de docker.

```
for image in $(docker images -q ); do docker inspect $image | jq -r 'map([.<campo1>,..., .<campoN>])'; done 
```

Explicación:
- ```docker images -q```: saca los IDs de las imágenes de docker
- ```docker inspect <id_imagen>```: Saca los metadatos de la imagen
- ```jq -r 'map([.<campo1>,...,.<campoN>])'

Para saber los campos, primero tendríamos que hacer el _docker inspect_ de una de las imágenes para ver los campos que hay.
