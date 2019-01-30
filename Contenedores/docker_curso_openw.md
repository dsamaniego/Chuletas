# Cursos de docker OpenWebinars

__¿Qué ofrece Docker?__

* Virtualización a nivel de S.O.
* Aislamiento de recursos a nivel de Kernel:
  * _cgroups_
  * _namespaces_
* Flexibilidad y portabilidad
* Enfocado a sistemas altamente distribuidos.

## Características

Las características principales de los contenedores son su portabilidad, su inmutabilidad y su ligereza:

### Portabilidad

Un contenedor es ejecutado por lo que se denomina el Docker Engine, un demonio que es fácilmente instalable en todas las distribuciones Linux y también en Windows. Un contenedor ejecuta una imagen de docker, que es una representación del sistema de ficheros y otros metadatos que el contenedor va a utilizar para su ejecución. Una vez que hemos generado una imagen de Docker, ya sea en nuestro ordenador o vía una herramienta externa, esta imagen podrá ser ejecutada por cualquier Docker Engine, independientemente del sistema operativo y la infraestructura que haya por debajo.

### Inmutabilidad

Una aplicación la componen tanto el código fuente como las librerías del sistema operativo y del lenguaje de programación necesarias para la ejecución de dicho código. Estas dependencias dependen a su vez del sistema operativo donde nuestro código va a ser ejecutado, y por esto mismo ocurre muchas veces aquello de que “no sé, en mi máquina funciona” . Sin embargo, el proceso de instalación de dependencias en Docker no depende del sistema operativo, si no que este proceso se realiza cuando se genera una imagen de docker. Es decir, una imagen de docker (también llamada repositorio por su parecido con los repositorios de git ) contiene tanto el código de la aplicación como las dependencias que necesita para su ejecución. Una imagen se genera una vez y puede ser ejecutada las veces que sean necesarias, y siempre ejecutará con las misma versión del código fuente y sus dependencias, por lo que se dice que es inmutable. Si unimos inmutabilidad con el hecho de que Docker es portable, decimos que Docker es una herramienta fiable, ya que una vez generada una imagen, ésta se comporta de la misma manera independientemente del sistema operativo y de la infraestructura donde se esté ejecutando.

### Ligereza

Los contenedores corriendo en la misma máquina comparten entre ellos el sistema operativo, pero cada contenedor es un proceso independiente con su propio sistema de ficheros y su propio espacio de procesos y usuarios (para este fin Docker utiliza cgroups y namespaces , recursos de aislamiento basados en el kernel de Linux). Esto hace que la ejecución de contenedores sea mucho más ligera que otros mecanismos de virtualización. Comparemos por ejemplo con otra tecnología muy utilizada como es Virtualbox. Virtualbox permite del orden de 4 ó 5 máquinas virtuales en un ordenador convencional, mientras que en el mismo ordenador podremos correr cientos de containers sin mayor problema, además de que su gestión es mucho más sencilla.

Como casi todas las librerías que van a necesitar nuestros contenedores ya están en memoria, se ejecutan muy rápido y gastan pocos recursos.

Se les puede asignar límites de memoria y CPU con lo que no nos van a "desbordar" el sistema.

## Arquitectura

Docker está formado fundamentalmente por tres componentes:

* Docker Engine
* Docker Client
* Docker Registry

!(./Arq_docker.png)

### Docker Engine o Demonio Docker

Es un demonio que corre sobre cualquier distribución de Linux (y ahora también en Windows) y que expone una API externa para la gestión de imágenes y contenedores (y otras entidades que se van añadiendo en sucesivas distribuciones de docker como volúmenes o redes virtuales). Podemos destacar entre sus funciones principales:

* Creación de imágenes docker.
* Publicación de imágenes en un Docker Registry o Registro de Docker.
* Descarga de imágenes desde un Registro de Docker
* Ejecución de contenedores usando imágenes locales.

Otra función fundamental del Docker Engine es la gestión de los contenedores en ejecución, permitiendo parar su ejecución, rearrancarla, ver sus logs o sus estadísticas de uso de recursos.

### Docker Registry o Registro Docker

El Registro es otro componente de Docker que suele correr en un servidor independiente y donde se publican las imágenes que generan los Docker Engine de tal manera que estén disponibles para su utilización por cualquier otra máquina. Es un componente fundamental dentro de la arquitectura de Docker ya que permite distribuir nuestras aplicaciones. El Registro de Docker es un proyecto open source que puede ser instalado gratuitamente en cualquier servidor, pero Docker ofrece Docker Hub, un sistema SaaS de pago donde puedes subir tus propias imágenes, acceder a imágenes públicas de otros usuarios, e incluso a imágenes oficiales de las principales aplicaciones como son: MySQL, MongoDB, RabbitMQ, Redis, etc.

El registro de Docker funciona de una manera muy parecida a git (de la misma manera que Dockerhub y sus métodos de pago funcionan de una manera muy parecida a Github ). Cada imagen, también conocida como repositorio, es una sucesión de capas. Es decir, cada vez que hacemos un build en local de nuestra imagen, el Registro de Docker sólo almacena el diff respecto de la versión anterior, haciendo mucho más eficiente el proceso de creación y distribución de imágenes.

### Docker Client o Cliente Docker

Es cualquier herramienta que hace uso de la api remota del Docker Engine, pero suele hacer referencia al comando docker que hace las veces de herramienta de línea de comandos (cli) para gestionar un Docker Engine. La cli de docker se puede configurar para hablar con un Docker Engine local o remoto, permitiendo gestionar tanto nuestro entorno de desarrollo local, como nuestros servidores de producción.

## Ciclo de desarrollo

Docker transforma radicalmente el concepto de entorno local de desarrollo.

Los desarrolladores pueder correr contenedores con las dependencias externas de la aplicación que están desarrollando, tales como nginx o mysql . También corren la aplicación que están desarrollando en su propio contenedor. Una vez que han terminado el desarrollo de una nueva funcionalidad y los tests pasan en local se puede hacer push de la nueva imagen que han desarrollado al Registro. La imagen pusheada puede ser descargada en los servidores de producción para desplegar una nueva versión de nuestra aplicación con la garantía de que se comportará de la misma manera que en el entorno local del desarrollador gracias a las propiedades de portabilidad e inmutabilidad de los contenedores. Este ciclo de desarrollo es la gran ventaja que aporta Docker a los ciclos de desarrollo de software, y la razón por la que Docker se ha hecho tan popular.

## Comandos docker

 Una vez que tenemos docker corriendo en nuestra máquina, podemos empezar a ejecutar algunos comandos:

* `docker version`: da información sobre la versión de docker que estamos corriendo.
* `docker info`: da información acerca de la cantidad de contenedores e imágenes que está gestionando la máquina actual, así como los plugins actualmente instalados.
* `docker run`: crea un contenedor a partir de una imagen. Este comando permite multitud de parámetros, que son actualizados para cada versión del Docker Engine, por lo que para su documentación lo mejor es hacer referencia a la página oficial.
* `docker ps`: muestra los contenedores que están corriendo en la máquina.
  * Con el flag **-a** muestra también los contenedores que están parados.
  * Con el flag **-q** muestra solo los identificadores (esto nos puede ser útil para automatizar tareas).
* `docker exec`: ejecuta un comando en un contenedor. Útil para depurar contenedores en ejecución con las opciones:  
  `docker exec -it contenedor bash`
* `docker cp`: copia archivos entre el host y un contenedor.
* `docker logs`: muestra los logs de un contenedor.
* `docker stats`: muestras las estadísticas de ejecución de un contenedor.
* `docker system prune`: utilidad para eliminar recursos que no están siendo usados en este momento.

También podemos configurar el cliente de docker para hablar con Docker Engines remotos usando las variables de entorno:

~~~ bash
export DOCKER_HOST="tcp://ucp.dckr.io:443"
export DOCKER_TLS_VERIFY=1
export DOCKER_CERT_PATH="~/ucp/stage"
~~~

Para conectar a un Docker Engine escuchando en la url [tcp://ucp.dckr.io:443] y usando TLS y los certificados del directorio **~/ucp/stage**. Si la conexión fuera abierta, indicaríamos **export DOCKER_TLS_VERIFY=0**.

Esto puede ser muy útil.

## Imágenes y contenedores

Docker Engine, tiene tres componentes:

* Demonio de Docker.
* REST API para comunicarse con el demonio.# Cursos de docker OpenWebinars
* CLI (docker)

*Docker Registry*: Servicio para almacenar imágenes.

* Públicos: [Docker Hub](https://hub.docker.com)
* Privados.

### Imágenes

* Plantillas de sólo lectura.
* Sistema de ficheros y parámetros listos para ejecutar.
* Todas basadas en S.O. Linux.

#### Comandos para gestionar imágnes

* `docker images` --> Muestra las imágenes instaladas.
* `docker history <img>` --> Muestra el historial de cambios de la imagen.
* `docker inspect <img>` --> Muestra información sobre la imagen.
* `docker save/load` --> Salva o carga una imagen
* `docker rmi <img>` --> Borra una imagen del host

## Contenedor

* La instanciación de una imagen.
* Es un directorio dentro del sistema.
* Pueden ser ejecutados, reiniciados, parados, etc...

### Comandos para gestionar contenedores

* `docker attach <cont>`: Nos agregamos a un contenedor activo.
* `docker exec <cont>`: Ejecutamos lo que sea en un contenedor .
* `docker inspect <cont>`: Muestra características del contenedor.
* `docker kill <cont>`: Mata un contenedor en ejecución.
* `docker logs <cont>`: Muestra los logs del contenedor.
* `docker ps`: Muestra los contenedores activos. (con la opción **-a** muestra todos los contenedores).
* `docker pause/unpause <cont>`: Pausa/Resume un contenedor.
* `docker rename <cont>`: Renombra un contenedor.
* `docker start/stop/restart <cont>`: pues eso.
* `docker port`: Muestra los puertos expuestos de un contenedor.
* `docker rm <cont>`: Borra un contenedor (tiene que estar parado).
* `docker run`: Instancia un contenedor a partir de una imagen.
* `docker stats`: Muestra los status de un contenedor.
* `docker top`: Monitorización del contenedor.
* `docker update`: Actualización de un contenedor a partir de una imagen.

## Crear imágenes. Dockerfile

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
jose@amadablam:~/Docker$ sudo docker commit -m "Añadido soporte Passenger" -a "José Hícar" b8f55f46a1c1 basajaun666/cursodocker/apache-php-passenger:latest#### Características
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

## Añadir una imagen al repositorio

Una vez construida la imagen (siguiendo el método que sea), la podemos subir a nuestro repositorio de docker hub, para eso:

1. Creamos el repositorio en DockerHub.
2. Añadimos una etiqueta a la imagen:  
   `docker tag 8a1670444f3b basajaun666/apache-php-passenger:latest`
3. Nos logamos en docker hub:  
   `docker login`
4. Subimos la imagen:  
   `docker push basajaun666/apache-php-passenger:latest`

## Networking

Docker cuando se instala crea con 3 redes:

~~~ bash
root@amadablam:~# docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
af5fec7252c9        bridge              bridge              local
b1a3fd243d61        host                host                local
2917770f9da4        none                null                local
~~~

* La red **bridge** es la red por defecto a la que se conecta cualquier docker que tenga red.
* La red **host** es la red a la que se tiene que conectar un contenedor que quiera comunicarse con otros dentro del host.
* La red **none** es la red que tiene un contenedor que queramos tener aislado

### Gestión de Networking (comandos)

1. Conectar un contenedor a una red:  
   `docker network connect/disconnect`
2. Crea una red:  
   `docker network create`
3. Ve las propiedades de una red:  
   `docker network inspect`
4. Lista las redes:  
   `docker network ls`
5. Borra una red:  
   `docker network rm`

### Redes bridge

La red de tipo _bridge_ es la red por defecto y representa la interfáz _docker0_ del host local y aislan segmentos de red de forma que los contenedores dentro  de una red bridge se comunican entre sí pero no con el exterior.

~~~ bash
root@amadablam:~# ifconfig -a
docker0: flags=4099<UP,BROADCAST,MU#### CaracterísticasLTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:4c:2f:a1:92  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
~~~

El puente de bridge en el contenedor se enlaza con la intefaz docker0 del host.

Un contenedor pude tener varias redes bridge y odos los contedores dentro de la misma red bridge tienen comunicación entre sí (y tiene el mismo gateway).

#### Propiedades

* Aíslan segmentos de red.
* Se añaden o quitan contenedores.
* Los contenedores se comunican sólo dentro de la red pero no entre redes.
* Un container añadido a dos redes se comunica con los miembros de ambas redes.
* Un container con varias redes tiene salida externa con la primera red no interna, en orden léxica.

### Links

Es una red especial que permite hacer Link entre contenedores.

Características:

* No es necesario exponer puertos.
* Descubre servicios y transfiere información de forma segura.
* Importante el uso de nombres.
* Utiliza variables de entorno para almacenar datos

## Almacenamiento

Vamos a ver cómo gestionar nuestros datos en Docker. Aprenderemos cómo crear diferentes formas de almacenar nuestros datos y veremos cómo gestionar estos datos para asociarlos a los contenedores.

Si creamos varios contenedores que se arrancan con el mismo contendor de volumen de datos, y hacemos cambios en los datos en uno de los contendores, este se encuentra modificado de forma instantánea en los demás, puesto que la fuente de información es la misma. Esta es una de las grandes ventajas de Docker para proveer escalabilidad horizontal de los servicios.

Dos forma de gestionar el almacenamiento de datos:

* **_Volumen de datos_** directorio especial que crea docker que permite almacenar datos de forma persistente.
  * Permite tener los datos de forma persistente y compartida.
  * Cuando se inicializa el contenedor, se inicializa el volumen, pero cuando se destruye el contendor no se destruye el volumen.
* **_Contenedor de volumen de datos_** si la imagen del contenedor contiene información, esta es copiada al volumen de datos.
  * Tiene como objetivo almacenar información persistente.
  * Se usa para centralizar la información persistente de un contenedor, lo que permite actuar sobre los servicios ofrecidos por los contenedores sin afectar a los datos.
  * Los datos son más fáciles de respaldar.

### Comandos de gestión de volúmenes

1. Creación de un volumen: `docker volume create`
2. Ver información de un volumen: `docker volume inspect <id>`
3. Listar los volúmenes: `docker volume ls <id>`
4. Borra un volumen: `docker volume rm <id>`

Para usar un volumen de datos en un contenedor:

~~~ bash
docker run -d -P -name web -v /webapp ubuntu/tomcat python app.py
~~~

Si hacemos un `docker volume inspect` del volumen de da Las características principales de los contenedores son su portabilidad, su inmutabilidad y su ligereza:
Portabilidad

Un contenedor es ejecutado por lo que se denomina el Docker Engine , un demonio que es fácilmente instalable en todas las distribuciones Linux y también en Windows. Un contenedor ejecuta una imagen de docker, que es una representación del sistema de ficheros y otros metadatos que el contenedor va a utilizar para su ejecución. Una vez que hemos generado una imagen de Docker, ya sea en nuestro ordenador o vía una herramienta externa, esta imagen podrá ser ejecutada por cualquier Docker Engine, independientemente del sistema operativo y la infraestructura que haya por debajo.
Inmutabilidad

Una aplicación la componen tanto el código fuente como las librerías del sistema operativo y del lenguaje de programación necesarias para la ejecución de dicho código. Estas dependencias dependen a su vez del sistema operativo donde nuestro código va a ser ejecutado, y por esto mismo ocurre muchas veces aquello de que “no sé, en mi máquina funciona” . Sin embargo, el proceso de instalación de dependencias en Docker no depende del sistema operativo, si no que este proceso se realiza cuando se genera una imagen de docker. Es decir, una imagen de docker (también llamada repositorio por su parecido con los repositorios de git ) contiene tanto el código de la aplicación como las dependencias que necesita para su ejecución. Una imagen se genera una vez y puede ser ejecutada las veces que sean necesarias, y siempre ejecutará con las misma versión del código fuente y sus dependencias, por lo que se dice que es inmutable. Si unimos inmutabilidad con el hecho de que Docker es portable, decimos que Docker es una herramienta fiable, ya que una vez generada una imagen, ésta se comporta de la misma manera independientemente del sistema operativo y de la infraestructura donde se esté ejecutando.
Ligereza

Los contenedores corriendo en la misma máquina comparten entre ellos el sistema operativo, pero cada contenedor es un proceso independiente con su propio sistema de ficheros y su propio espacio de procesos y usuarios (para este fin Docker utiliza cgroups y namespaces , recursos de aislamiento basados en el kernel de Linux). Esto hace que la ejecución de contenedores sea mucho más ligera que otros mecanismos de virtualización. Comparemos por ejemplo con otra tecnología muy utilizada como es Virtualbox. Virtualbox permite del orden de 4 ó 5 máquinas virtuales en un ordenador convencional, #### Característicasmientras que en el mismo ordenador podremos correr cientos de containers sin mayor problema, además de que su gestión es mucho más sencilla. tos, veremos donde está en nuestro fichero físico (suele ser en ____/vr/lib/docker/volumes____).

Compartir un directorio de la máquina física en un contenedor. En el ejemplo nos es útil tener en local los logs del balanceador _nginx_, que permanecerán aunque paremos el contenedor.

~~~ bash
[local]: mkdir /nginx_logs
[local]: docker run -d -v /ngix_logs:/var/logs/nginx -p 81:80 -ti nginx
~~~

Para usar un contenedor de volúmen (usar un contenedor como almacenamiento):

~~~ bash
docker create -v /tmp --name datacontainer ubuntu
docker run -rm -ti --volumes-from datacontainer ubuntu /bin/bash
~~~

## Arquitecturas de microservicios

El concepto de microservicios tiene sus orígenes en la arquitectura SOA (_Service Oriented Architecture_). SOA se basa en el antiguo principio de “divide y vencerás”, y sostiene un modelo distribuido para el desarrollo de aplicaciones frente a soluciones clásicas más monolíticas.

### Arquitecturas SOA

Una arquitectura basada en SOA debe seguir una serie de principios para ser exitosa. Estos principios son:

* Cada servicio debe ofrecer un contrato para conectarse con él. Un caso muy común es un servicio que ofrece una **API REST**. Dicha API debe siempre mantener compatibilidad con versiones anteriores, o gestionar versiones de sus endpoints cuando se producen incompatibilidades, pero es fundamental no romper el contrato con otros servicios.
* Cada servicio debe minimizar las dependencias con el resto. Para esto es fundamental acertar con el scope de un servicio. Una indicación de que el scope no es el adecuado es cuando se producen dependencias circulares entre los servicios.
* Cada servicio debe abstraer su implementación. Para el resto de servicios debe ser transparente si un servicio usa un backend u otro para la base de datos o si ha hecho una nueva release.
* Los servicios deben diseñarse para maximizar su reutilización dado que la reutilización de componentes es una de las ventajas de una arquitectura SOA.
* Cada servicio tiene que tener un ciclo de vida independiente, desde su diseño hasta su implantación en los entornos de ejecución.
* La localización física de donde corre un servicio debe ser transparente para los servicios que lo utilizan.
* En lo posible, los servicios deben evitar mantener estado.
* Es importante mantener la calidad de los servicios. Un servicio con continuas regresiones puede afectar a la calidad final percibida por el resto de servicios que hacen uso de él.

### Microservicios

Teniendo en cuenta estos principios, el concepto de microservicio es un poco la manera que se ha puesto de moda para referirse a las arquitecturas SOA, pero incidiendo más aún en que la funcionalidad de dichos servicios debe ser la mínima posible. Una medida bastante extendida es que un microservicio es un componente que debería ser desarrollable en unas dos semanas. Las ventajas de una arquitectura basada en microservicios son las siguientes:

* Son componentes pequeños que agilizan los procesos de desarrollo de software y son fáciles de abordar por un equipo de desarrolladores.
* Son servicios independientes, si un microservicio falla no debería afectar a los demás.
* El despliegue de un microservicio a producción es más sencillo que el de una aplicación monolítica.
* Los microservicios son altamente reutilizables.
* Los microservicios son más fáciles de externalizar.

### Docker y los microservicios

El despliegue de un microservicio suele ser más sencillo que el de una aplicación monolítica debido a su mayor sencillez y sus menores dependencias. Por otra parte, los microservicios agilizan los procesos de desarrollo del software permitiendo casos de uso donde al día podemos hacer varios despliegues de distintos microservicios. Es por tanto casi imposible concebir una arquitectura basada en microservicios sin la automatización de los procesos de integración y despliegue continuo. Ésta es la principal relación entre Docker y los microservicios ya que Docker es una herramienta excepcional para la automatización de estas tareas. Docker simplifica la automatización de construir una imagen, distribuirla y ejecutarla en cualquier máquina independientemente de la infraestructura. Esto significa que podemos construir una imagen en nuestros entornos de integración continua, correr nuestras pruebas contra ella, distribuirla en nuestro servidores de producción y por último, ejecutarla en un contenedor. Y todo esto ejecutando simplemente unos cuantos comandos de docker.

Dicho esto, una arquitectura de microservicios es sólo un modelo de desarrollo de software que mal aplicado puede traer enormes quebraderos de cabeza. Los microservicios adquieren más importancia cuando tenemos equipos de ingeniería muy grandes, que interesa dividir en subgrupos y cada uno de ellos se encargue de uno (o unos pocos) microservicios. Además, el proceso de migrar una arquitectura monolítica a una arquitectura basada en microservicios debe ser planeado con cautela. Se recomienda transferir un trozo de lógica a un sólo microservicio a la vez, ya que una arquitectura basada en microservicios puede implicar un cambio de las herramientas utilizadas para el despliegue, monitoreo y sistemas de logging de nuestras aplicaciones.

Nos gustaría destacar que Docker se adapta perfectamente a una arquitectura basada en microservicios, pero sería posible tener una arquitectura basada en microservicios sin usar contenedores, y por supuesto, es perfectamente posible usar Docker en una arquitectura más monolítica o no basada en microservicios. Imaginemos el caso de una aplicación legacy monolítica. Solo por el hecho de meter esta aplicación dentro de un contener, tal y como es, sis cambios en su código fuente, nos vamos a beneficiar de muchas de las características de docker, como son:

* Facilidad de levantar entonos locales de desarrollo.
* Portabilidad para correr nuestro contenedor en un Mac, en un Ubuntu, en integración continua o en un servidor de producción.
* Facilidad para distribuir las imágenes de nuestra aplicación.

Dicho de otra manera. No es necesario modificar nuestras aplicaciones de toda la vida para adaptarlas a Docker, Docker se adapta a nuestras aplicaciones tal y como son. Hay un conjunto de buenas prácticas para seguir una arquitectura basada en microservicios, pero solo son eso, buenas prácticas que dependiendo del contexto conviene o no aplicar, si no, serían axiomas de desarrollo. Mostramos esta idea en la siguiente figura:

!(./Contenedores/monolitic_vs_microserv.png)

En la parte de la izquierda tenemos una aplicación monolítica corriendo en un host con cuatro procesos principales: __systemd_, _nginx_ ,un proceso _python_ y un proceso _node.js_. El proceso de dockerizar sería construir una imagen de docker con la misma arquitectura de procesos, pero esto nos permite hacer push y pull de esta imagen de una manera muy sencilla, y corren en cualquier entorno de ejecución con total garantía. Más tarde, y si así se decide, podemos separar cada proceso en su propio microservicio, que sería la parte de la derecha, donde cada proceso corre en un contenedor independiente. Lo que queremos destacar es que la fase de dockerizar, aunque luego no se adopte una arquitectura de microservicios, es de enorme valor en sí mismo. También que saltarse este paso y tratar de pasar de la arquitectura de la derecha a la de la izquierda en un solo paso suele ser una garantía para buscar problemas.

## Contrucción de imágenes

### Docker Build y Dockerfile

Como vimos en la introducción a Docker, una imagen se corresponde con la información necesaria para arrancar un contenedor, y básicamente se compone de un sistema de archivos y de otros metadatos como son el comando a ejecutar, las variables de entorno, los volúmenes del contenedor, los puertos que utiliza nuestro contenedor…

La manera recomendada de construir una imagen es utilizar un fichero **Dockerfile**, un fichero con un conjunto de instrucciones que indican cómo construir una imagen de Docker. Las instrucciones principales que pueden utilizarse en un Dockerfile son:

* **FROM image**: para definir la imagen base de nuestro contenedor.
* **RUN comando**: para ejecutar un comando en el contexto de la imagen.
* **ENTRYPOINT comando**: para definir el entrypoint que ejecuta el container al arrancar.
* **CMD comando**: para definir el comando que ejecuta el container al arrancar.
* **WORKDIR path**: para definir el directorio de trabajo en el contenedor.
* **ENV var=value**: para definir variables de entorno.
* **EXPOSE puerto**: para definir puertos donde el contenedor acepta conexiones.
* **COPY origen destino**: para copiar ficheros dentro de la imagen. También se usa para multi-stage builds.

Para una lista completa de las instrucciones disponibles ir a la documentación oficial .

Un ejemplo de un dockerfile para una aplicación Flask en python podría ser:

~~~ dockerfile
FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev
WORKDIR /app
ENV DEBUG=True
EXPOSE 80
VOLUME /data
COPY . /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]
~~~