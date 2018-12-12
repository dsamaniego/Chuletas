# Cursos de docker OpenWebinars.

## ¿Qué ofrece Docker?
* Virtualización a nivel de S.O.
* Aislamiento de recursos a nivel de Kernel:
	* _cgroups_
	* _namespaces_
* Flexibilidad y portabilidad
* Enfocado a sistemas altamente distribuidos.

Como casi todas las librerías que van a necesitar nuestros contenedores ya están en memoria, se ejecutan muy rápido y gastan pocos recursos.

Se les puede asignar límites de memoria y CPU con lo que no nos van a "desbordar" el sistema.

# Imágenes y contenedores.
Docker Engine, tiene tres componentes:
* Demonio de Docker.
* REST API para comunicarse con el demonio.
* CLI (docker)

*Docker Registry*: Servicio para almacenar imágenes.
* Públicos: [Docker Hub](https://hub.docker.com)
* Privados.

## Imágenes.
* Plantillas de sólo lectura.
* Sistema de ficheros y parámetros listos para ejecutar.
* Todas basadas en S.O. Linux.

### Comandos para gestionar imágnes:
* `docker images` --> Muestra las imágenes instaladas.
* `docker history <img>` --> Muestra el historial de cambios de la imagen.
* `docker inspect <img>` --> Muestra información sobre la imagen.
* `docker save/load` --> Salva o carga una imagen
* `docker rmi <img>` --> Borra una imagen del host

## Contenedor.
* La instanciación de una imagen.
* Es un directorio dentro del sistema.
* Pueden ser ejecutados, reiniciados, parados, etc... 

### Comandos para gestionar contenedores:
* `docker attach <cont>` --> Nos agregamos a un contenedor activo.
* `docker exec <cont>` --> Ejecutamos lo que sea en un contenedor .
* `docker inspect <cont>` --> Muestra características del contenedor.
* `docker kill <cont>` --> Mata un contenedor en ejecución .
* `docker logs <cont>` --> Muestra los logs del contenedor.
* `docker ps` --> Muestra los contenedores activos.
* `docker pause/unpause <cont>` --> Pausa/Resume un contenedor.
* `docker rename <cont>` --> Renombra un contenedor.
* `docker start/stop/restart <cont>`
* `docker port` --> 
* `docker rm <cont>` --> Borra un contenedor (tiene que estar parado).
* `docker run` --> Instancia un contenedor a partir de una imagen. 
* `docker stats` --> Muestra los status de un contenedor.
* `docker top` --> Monitorización del contenedor.
* `docker update` --> Actualización de un contenedor a partir de una imagen.

## Crear imágenes. Dockerfile.
La idea es que nosotros arranquemos un contenedor y nos lo configuremos como queramos, y a parir de ahí crearnos otro nuevo contenedor. Esto lo haríamos con `docker commit`.

Hay que tener en cuenta, que cada comando que ejecutamos en el contenedor es una capa que añadimos al contenedor, lo que hace que sea más grande.
Por ejemplo:
~~~ bash
jose@amadablam:~/Docker$ sudo docker ps -a
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS                     PORTS               NAMES
4fa665378183        eboraas/apache-php   "/usr/sbin/apache2ct…"   10 seconds ago      Up 9 seconds               80/tcp, 443/tcp     naughty_jackson
b8f55f46a1c1        eboraas/apache-php   "/bin/bash"              6 minutes ago       Exited (0) 2 minutes ago                       vigilant_torvalds

~~~

Creamos un contenedor nuevo:
~~~bash
jose@amadablam:~/Docker$ sudo docker commit -m "Añadido soporte Passenger" -a "José Hícar" b8f55f46a1c1 basajaun666/cursodocker/apache-php-passenger:latest
sha256:fcad53f4eabe1db5ac727f5e08acb3a1261f566b5f214591f0c0d592788c9a09
jose@amadablam:~/Docker$ sudo docker start b8f55f46a1c1
b8f55f46a1c1
jose@amadablam:~/Docker$ sudo docker ps -a
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS              PORTS               NAMES
4fa665378183        eboraas/apache-php   "/usr/sbin/apache2ct…"   2 minutes ago       Up 2 minutes        80/tcp, 443/tcp     naughty_jackson
b8f55f46a1c1        eboraas/apache-php   "/bin/bash"              8 minutes ago       Up 5 seconds        80/tcp, 443/tcp     vigilant_torvalds
jose@amadablam:~/Docker$ sudo docker commit -m "Añadido soporte Passenger" -a "José Hícar" b8f55f46a1c1 basajaun666/cursodocker/apache-php-passenger:latest
sha256:fcad53f4eabe1db5ac727f5e08acb3a1261f566b5f214591f0c0d592788c9a09
~~~

Otra forma -mejor- de hacerlo es:
* Creamos un fichero _Dockerfile_ con las instrucciones para construir el contenedor.
* Con el comando `docker build` construimos el contenedor definido en el _Dockerfile_.

## Añadir una imagen al repositorio.
Una vez construida la imagen (siguiendo el método que sea), la podemos subir a nuestro repositorio de docker hub, para eso:
1. Creamos el repositorio en DockerHub.
2. Añadimos una etiqueta a la imagen: `docker tag 8a1670444f3b basajaun666/apache-php-passenger:latest`
3. Nos logamos en docker hub: `docker login`
4. Subimos la imagen: `docker push basajaun666/apache-php-passenger:latest`

# Networking.

# Almacenamiento.
