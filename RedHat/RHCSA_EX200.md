# Tabla de contenidos
0. [Introducción al curso](#introduccion)
   1. [Internacionalización](#intennacionalizacion)
      1. [Opciones de lenguaje](#language)
1. [Acceso a la línea de comandos](#consola)
   1. [Entorno gráfico](#graphic_console)
   2. [Terminales y consolas](#console)
2. [Manejo de archivos con la línea de comandos](#manage_files)
   1. [Jerarquía de directorios](#file_hierachy)
   2. [Conceptos](#file_concepts)
   3. [Manejo de fichreros](#file_mngmt)
   4. [File Globbing](file_globbing)
   5. [Sustitución de comandos](#command_subs)
3. [Obtener ayuda](#help)
   1. [Comandos útiles](#hlp_cmd)
4. [Ficheros de texto](#txt_files)
   1. [Redirecciones](#redir)
      1. [Entrada desde un fichero](#file_input)
      2. [Redirecciones de salida](#output_redir)
   2. [Tuberías](#pipes)
      1. [tee](#tee)
5. [Usuarios y grupos](#user_group_mngmt)
   1. [Administración de usuarios](#admin_users)
      1. [Rangos de UIDs](#UID_range)
   2. [Administración de grupos locales](#group_admin)
   3. [Contraseñas](#passwd)
6. [Permisos](#perms)
   1. [Cambiar permisos](#chmod)
   2. [Cambiar propietarios](#chown)
   3. [Permisos especiales](#setuid)
7. [Monitorización y administración de procesos](#proc)
   1. [Comandos](#proc_cmd)
   2. [Señales](#signals)
   3. [Monitorización de procesos](#proc_monitoring)
8. [Control de servicios y demonios](#systemd)
   1. [Comando _systemctl](#systemctl)
   
# Introducción al curso <a name="introduccion"></a>
[kiosk@foundation12 ~]$ find /etc -name passwd 2> /dev/null |tee /dev/pts/1 > ~/encontrados4.txt

#### Máquinas clase

* Máquina: **foundation12** (172.25.254.12 - 172.25.12.1), user: kiosk / lamia
* Máquinas virtuales:
  * **desktop12** (172.15.12.10): student/student - root/redhat
  * **server12** (172.15.12.11): student/student - root/redhat
* Máquina del profe: **classroom** (172.25.0.254)

##### Controlar las máquinas virtuales

Programa `rht-vmctrl`, opciones:
* reset -- restaura la máquina hasta el último snapshot guardado
* view -- abre la consola
* start -- arranca la VM
* save -- hace el snapshot
* fullreset -- vuelve la VM al origen de los tiempos.

#### Máquinas casa

Hemos creado 3 máquinas Centos con vagrant en amadablam, con el usuario _student_ (Pass:student) y el _root_ (Pass:vagrant)
* server: 10.0.100.101
* desktop1: 10.0.100.102
* desktop2: 10.0.100.103

Tenemos un snapshot inicial de cada una de ellas en las que ya está creado el suario _student_

## Internacionalización <a name="internacionalizacion"></a>

Control de la configruación de gnome: `gnome-control-center`. Entre otras tiene las siguientes opciones.
* _region_: Establece las opciones de región y lenguaje (incluidos formatos).
* _datetime_: Establece opciones de fecha y hora.

### Opciones de lenguaje <a name="language"></a>

La configuración del lenguaje de cada usuario en gnome se guarda en: /var/lib/AccountService/users/${USER}
Para establecer un lenguaje para un comando:
* `$ LANG=<codigo> <comando>`, con de código es uno de los admitidos 
* `localectl list-locales`, muestra todos los códigos
* Si accedemos a la máquina por ssh: `loadkeys es` (se pierde cada vez que se reinicie la máquina).
* Podemos tocar a mano el fichero `/etc/vconsoles.conf`
* La manera más cómoda es cambiarlo en el entorno gráfico.

# Acceso a la línea de comandos <a name="consola"></a>

## Entorno gráfico <a name="graphic_console"></a>

El entorno gráfico por defecto en RHEL7 es Gnome3, que corre sobre XW

Tiene dos modos: _classic_ y _modern_.

Cuando se entra por primera vez, se hace un setup inicial al ejecutarse `/usr/libexec/gnome-initial-setup`, (en cualquier momento podemos volver a lanzarlo para reconfigurar el entorno), después arranca el _Gnome Help_, al que siempre se puede ir pulsando **F1** o, desde un terminal ejecutando `yelp`, o desde el menú: **Application --> Documentation --> Help**.

Incluso en el entorno gráfico tenemos consolas, para acceder a ellas hay que pulsar las combinaciones de teclas **Ctrl+Alt+[F2-F6]**, para volver al entorno gráfico: **Ctrl+Alt+F1**.

## Terminales y consolas <a name=console></a>

Aquí hay que poner los atajos de teclado etc...

# Manejo de archivos con la línea de comandos <a name="manage_files"></a>

## Jerarquía de directorios <a name="file_hierachy"></a>

Los directorios en RHEL (como en todos los sabores Linux) se organizan en forma de árbol invertido en el que arriba está el directorio root (**/**).

En una jerarquí a LVM se encapsulan los directorios, como mínimo:
* raíz (**/**)
* arranque (**/boot**), será una partición separada con las imágenes estáticas de arranque.

## Conceptos <a name="file_concepts"></a>

* **Persistencia**: Se refiere a la resistencia a "sobrevivir" a los reinicios, los ficheros persistentes guardan cambios que se conservan entre reinicios. **IMPORTANTE: En el exámen todo tiene que quedar persistente, ya que hay varios reinicios.**
* **Runtime**: Cambios que se conservan mientras está encendida la máquina.

## Manejo de ficheros <a name="file_mngmt"></a>

* `touch`: Crea un fichero, si no existe, y le cambia el _timestamp_ si existe.
* `stat`: Da información relevante sobre el fichero

## File Globbing<a name="file_globbing"></a>

Para negar expresiones complejas de _file globbing_, meter un signo de exclamación entre los corchetes de apertura, por ejemplo: Ningun caracter alfabético: **[![:alpha:]]**

## Sustitución de comandos <a name="hlp_command"></a>

Tenemos dos formas de invocar un comando en línea de comandos:
- `$(comando)`
- \``comando`\`

Las dos son equivalentes, pero la primer opción permite anidamiento, por ejemplo:

~~~bash
VARIABLE=$(echo $PATH)
~~~

### Protección de argumentos

Si en una cadena tenemos que pasar una expresión, hay que usar comillas dobles, ya que las comillas simples hacen que todo lo que va dentro de unas comillas simples se considera un literal, mientras que las dobles comillas **"** permten sustitución de comandos y variables, pero suprimen en _file globbing_.

# Obtener ayuda <a name="help"></a>

El comando `man` está organizado en diferentes secciones de la 1 a la 8, las que mas nos interesan son:

* 1 - Comandos de usuario
* 5 - Formato de ficheros
* 8 - Comandos de administración y privilegiados

`mandb` Es un comando para actualizar la base de datos de ayuda, es útil correrlo cuando se instala algún nuevo paquete.

## Comandos útiles <a name="hlp_cmd"></a>

- `man -k <palabla>` Muestra todas las entradas de **man** en las que aparece esa palabra en el sumario. Es equivalente al comando `apropos <palabra>`.
- `man -K <palabra>` Como la anterior pero la búsqueda se extiende a todo el  artículo no solo al sumario.
- `man -t <termino_de_ayuda>` Prepara la página de man para imprimir en formato PostScript.
- `info` y `pinfo` Como **man** pero estructurado en nodos e hipervínculos, casi toda la ayuda del proyecto GNU está en este formato.
- `/usr/share/doc` Documentación de paquetes, hay algunos que se tienen que instalar explicitamente con un `yum install -y <paquete>-doc-xxx`, para verlo lo más sencillo es usar un navegador (por ejemplo: `firefox file:///usr/share/doc/yum`).

# Ficheros de texto <a name="txt_files"></a>

Vamos a ver cómo trabajar con entradas y salidas, redirecciones, etc...

Un proceso en ejecución tiene 4 flujos:
* entrada estándar (stdin) (canal 0)
* salida estándar (stdout) (canal 1)
* salida de error (stdout) (canal 2)
* salida a otros ficheros (canales, 3, 4, ...)

## Redirecciones <a name="redir"></a>

Operadores de redirección:
* **>** Escribe en un fichero, si existe, lo sobreescribe y si no existe lo crea
* **>>** Append, si existe, añade al fichero y si no lo crea.
* **<** 


Dispositivos especiales del sistema:
* `/dev/null`--> es un sumidero, todo lo que dirijamos a él se pierde.
* `/dev/zero`--> Si queremos meter ceros como entrada.

### Redirecciones de salida <a name="output_redir"></a>

Ojo, los operadores de fusión más modernos ( &>file &>>file) puede que no funcionen en shells antigüas.

### Entrada desde un fichero <a name="file_input"></a>

Podemos redirigir la salida como entrada a otro programa (por ejemplo en un bucle for):
~~~ bash
while read line
do
  echo "$line"
done < "${1:-/dev/stdin}
~~~

## Tuberías <a name="pipes"></a>

Otra forma de hacer que la salida de un fichero sea la entrada de otro comando es con un pipe **|**.

Para encadenar comandos, ya sabemos que hay que separar comandos por un **;**, para encadenar salidas de un proceso como entrada del siguiente, se usan las tuberías (enlazas las stdout).

### tee <a name="tee"></a>

Comando **tee** copia su stdin a stdout y al fichero que le digamos.

Ejemplos:
* `ls -l | tee /tmp/saved-output | less` --> la salida de tee va a pantalla y a un fichero
* `ls -l | tee /dev/pts/0| mail student@desktop1.example.com` --> El tee envía su salida al terminal y, a la vez al programa de correo electrónico (para ver el teminal, podemos usar el comando `tty` para ver el dispositivo de salida).

# Usuarios y grupos <a name="user_group_mngmt"></a>

Cada proceso y fichero tiene un usuario propietario.

Para ver la cuenta de usuario: comando **id**

Los usuarios se identifican en el sistema por su UID.

La configuración del usuario está en el fichero `/etc/passwd`, que contiene solo los usuarios locales. tiene 7 campos:
1. username
2. password (en desuso en ese fichero, la passwd está encriptada  en el fichero `/etc/shadow`, aquí tambien hay información de caducidades de contraseñas, etc...)
3. UID (el de root es 0)
4. GID, grupos del usuario, 1 principal y el resto secundarios.
   Cuando creamos el usuario se crea un grupo principal con el mismo nombre que el usuario
5. GECOS: String que usamos para identificar el usuario.
6. $HOME: directorio raíz del usuario
7. shell del usuario (podemos tener o `/sbin/nologin` -para evitar que el usuario no haga login ,por ejemplo, si va a usar servicios del sistema pero no necesita acceso a la shell de sistema ni manipular ficheros del sistema; o `/bin/false`, si no queremso que use nada de nuestro sistema).

Configuración de grupos, `/etc/group`:
1. nombre
2. Contraseña del grupo (normalmente no se pone).
3. GID
4. miembros del grupo

Relación de usuarios y grupos.

Un usuario puede tener **exactamente** un grupo principal, que es el GID que viene en el `/etc/passwd` y se corresponderá con una entrada del `/etc/group`. De hecho a este grupo se le llama _grupo privado_.

Cuando creamos un fichero se le asigma un usuario y grupo acorde con los del usuario que los ha creado.

Si se quieren añadir nuevas capacidades a un usuario, mejor añadir grupos suplementarios -mejor no cambiar el grupo principal.

## Conseguir acceso de superusuario <a name="root_access"></a>

El señor **root**, tiene todos los poderes sobre el sistema, sólo el puede administrar los dispositivos físicos del sistema.

Dado que tiene todos los privilegios, tiene una capacidad ilimitada de romper el sistema, es una cuenta que hay que tener **MUY** protegida.

**RECOMENDACIÓN:** Acceder como usuario normal y escalar privilegios. Ojo, los privilegios en consola no son lo mismo que los de GNOME.

¿Cómo escalamos privilegios?
* `su [-] <username>`:
   * el **-** indica que tomamos las variables de entorno del usuario al que escalamos.
   * si no ponemos usuario, escalamos a root.
   * Nos pedirá el passwd del usuario destino.
   * Problema... hay que conocer el passwd de root.
 * `sudo <username>`
   * Nos permite ejecutar lo que tengamos permitido en la configuración de sudo como usuario al que hemos escalado privilegios.
   * Nos pide el passwd del usuario que quiere escalar privilegios, con lo que no distribuimos la contraseña de root.
   * Con la opción **-i** nos permite abrir una shell con los privilegios del usuario con mayores privilegios.
   * En RHEL7: Si tenemos un usuario que pertenece al grupo **wheel** también tendrá privilegios en el fichero `sudoers`  
      Si hacemos un `visudo`, vemos la entrada por el grupo:
      ~~~bash
      %wheel  ALL=(ALL) ALL
      ~~~
      Características:
      * en el último ALL, podemos sustituir por:
         - NOPASSWD:NOEXEC:<comando>, que significa que no nos pide el passwd para hacer sudo, pero no nos dejaría ejecutar con privilegios.
      Que indica que usuarios del grupo wheel puede hacer sudo desde todas las terminales a todos los usuarios del sistema y ejecutar cualquier comando.
      En vi, si ejecutamos sudo vi, podremos ejecutar comandos como root ejecutando lo siguiente:  
         `:r! <comando>`
   * Deja logs en `/var/log/secure` de todas las acciones hechas por los usuarios.
   * Los ficheros de configuración están en `/etc/sudoers.d/*`
   * El fichero principal es el `/etc/sudoers` (para editarlo hay que usar **visudo** que hace chequeos de formato y si la cagamos no nos deja guardar.
   * No podremos usar sudo si nuestro usuario o el grupo no está metido en el fichero sudoers
   * Los ficheros de configuración que hay colgando de `/etc/sudoers.d/*` tienen preferencia sobre el `/etc/sudoers` (en general, las que estén en `/etc/<srv>.d/*`, tienen preferencia sobre lo que viene en `/usr/lib`
**_IMPORTANTE_**: si hacemos sudo <comando> > fichero y el usuario no tiene permisos para escribir el fichero, no podrá hacerlo, ya que por una parte se ejecuta el comando como el usuario destino, y luego se escribe el fichero como usuario origen.
   * `sudo -l` nos lista los permisos que tiene el usuario
   
Esto, no impide que cuando vayamos a trabajar con entornos gráficos, lo que nos restringe los permisos es el _Policy Kit_ de GNOME.

## Administración de usuarios <a name="admin_users"></a>

Crear usuarios **useradd \<usuario>**, nos añadirá una línea en `/etc/passwd`
Una vez añadido el usuario, tendremos que configurarlo, ya que nos lo crea sin contraseña.

Fichero inportante: /etc/login.defs
* Reglas y vigencias de las contraseñas.
* rangos definidos en el sistema
* UIDs y GIDs por defecto
* si modificamos algo en este fichero, a los usuarios que ya existen en el sistema no los afecta, así que cuidadin con los conflictos.

Todos los comandos generados de forma automática con el **useradd** se pueden modificar con **usermod**, la mayoría de los flags definidos en **useradd** se pueden usar en **useradd**.

**TRUCO** Antes de modificar un usuario, hacer un **id** para tener un _backup_ del usuario por si la cagamos.

Borrar usuarios con **userdel** (con la opción -r borra el $HOME del usuario), cuidadin... si creamos un usuario, lo borramos sin (-r) y volvemos a crear otro, este nuevo usuario coge el primer UID libre que será el que acabamos de dejar libre, con lo que este nuevo usuario puede coger permisos sobre ficheros no deseados, así que la mejor política es no borrar usuarios, sino bloquealos con `usermod -L <usuario>`

Para prevenir esto, como root, ejecutar: `find / -nouser -o -nogroup 2>/dev/null`

### Rangos de UIDs <a name="UID_range"></a>
* 0 --> root
* 1 - 200 --> de sistema usados por procesos
* 201-999 --> de sistema usados por procesos, sin acceso al sistema de ficheros
* > 1000 - Usuarios nominales

Todos estos rangos se pueden manipular en el `/etc/login.defs`

### Administración de grupos locales <a name="group_admin"></a>

**Añadir un grupo:** `groupadd [-g <GID>] <nombre_gr>`, si no le ponemos GID, nos da el siguiente GID de los grupos que no son del sistema.
**Renombrar un grupo:** `groupmod -n <nombre_nuevo> <nombre_antigüo>`  
**Cambiar el GID:** `groupmod -g <nuevo_GID> <nombre_gr>`, a partir de ahí todos los grupos que creemos se irán numerando a partir de este (aunque no especifiquemos), pero los grupos de usuarios seguirán creándose con lso 1000..., esto se hace para que no colisionen los grupos de trabajo con los grupos de usuarios.  
**Borrar grupo:** `groupdel <grupo>`, lo que vale para el borrado de usuarios, vale para los grupos. Más ojo todavía porque puede haber varios usuarios 
**Cambiar el grupo principal a un usuario:** `usermod -g <grupo> <username>`  
**Añadir grupos secundarios:** `usermod -aG <lista_secundarios> <username>`, si no ponemos el -a, sustituiremos los grupos secundarios que tenga por los nuevos.  

### Contraseñas <a name="passwd"></a>

`/etc/shadow` guarda las contraseñas cifradas y las características de vigencia y caducidad d ela contraseña.

Formato del fichero:
name:password:lastchange:minage:maxage:warning:inactive:expire:blank, donde:
* **name**: nombre dle usuario
* **password**: contraseña cifrada
* **lastchange**: fecha del último cambio (epoch)
* **minage**: Mínimo número de dias antes de poder cambiar la contraseña
* **maxage**: Máximo número de días de vigencia de una contraseña
* **warning**: dias de advertencia para cambiar la contraseña antes de que expire
* **inactive**: numero de días que la cuenta permance activa después de la expiración de la contraseña antes de que expire.
* **blank**: sin uso

#### Contraseña cifrada.

El has de la contraseña almacena 3 datos separados por _'$':$N$semilla$passwdCifrada_  
**$N$** -- Algoritmo de cifrado 1-6 (6 por defecto)  
**$semilla$** -- Semilla aleatoria para el cifrado  
**$cif_passwd$** -- Contraseña + uid cifrado

Cuando te logas e introduces el passwd, coge esa contraseña introducida y aplica el método de hash usado con la semilla y la compara con la almacenada, si coincide p'alante, y si no, caput.

Para cambiar el método de cifrado:
~~~bash
authconfig --passalgo=<Algoritmo_cifrado> --update
~~~

#### Vigencia de las contraseñas.
Se cambian con `chage -m m -M M -W x -I i username` donde:
* -m --> min days
* -M --> max days
* -W --> warn days
* -I --> inactive days

Si queremos forzar al cambio de contraseña en el siguiente login: `chage -d 0 <username>`  
Si queremos forzar que una contraseña caduque un día concreto: `chage -E YYYY-MM-DD <username>`  
Si queremos ver las configuraciones actuales de un usuario: `chage -l <username>`  

### Restricción de acceso

Podemos bloquear una cuenta con `usermod -L <usermod>` o con `usermod -L -e N <usermod>`, esta segunda opción dice que la cuenta se bloquee a los N días del 1-1-1970...

Importante, podemos tener un usuario sin bloquear pero que no puede acceder porque su constraseña ha caducado.

Podemos impedir que un usuario no acceda a la shell cambiando su shell a `/sbin/nologin` o `/bin/false` (esta para que no pueda hacer nada de nada.
~~~ bash
usermod -s /sbin/nologin <username>
~~~

# Permisos <a name="perms"></a>

Si hacemos un ls -l, vemos las sigueintes características:
~~~bash
kiosk@foundation12 ~]$ ls -l /etc/yum.conf
-rw-r--r--. 1 root root 813 Nov 26  2017 /etc/yum.conf
~~~

Vienen en 3 grupos USER - GROUP - OTHER y se aplican de izda a dcha, e.d. se aplican los permisos del primer grupo que cumpla.

En ficheros:  
r --> leer archivos  
w --> modificar archivos  
x --> ejecutar archivos

En directorios:  
r --> listar el contendio del directorio  
w --> borrar o añadir ficheros  
x --> puedo atravesar el directorio

OJO al crear estructuras de directorios, a ver si podemos atravesarlos. y no se heredan los permisos como en el caso de Windows.

Si quiero ver los permisos de un directorio: `ls -ld <directorio>`

## Cambiar permisos <a name="chmod"></a>

Se trabaja por grupos: - rwx rwx rwx   student  student  <fichero>, el propietario puede cambiar los permisos de todo.

**Notación simbólica:** `chmod who what which <file/dir>`
   * _who_: u, g, o, a (usuario, grupo, othos, todos).
   * _what_: =, +, - (poner explícitamente permisos, añadir, quitar)
   * _which_: r, w, x, X (lectura, escritura, ejecución, X se aplica x de forma recursiva a todos aquellos directorios que hay por el camino y a todos los ficheros en que alguien tiene permisos de ejecución).
      * la X se suele aplicar en directorios, se tiene que aplicar siempre con la opción **-R** de **chmod**.
**Notación octal:** `chmod sUGO <fichero>`

## Cambiar propietarios <a name="chown"></a>

Permite cambiar el propietario y el grupo, `chwon owner:group <file/dir>`, admite recursivo (**-R**).

Podemos cambiar el propietario (`chmod <user> <file/dir>`), el grupo (`chmod :<group> <file/dir>`) o los dos. El propietario sólo lo puede cambiar root, el grupo lo puede cambiar el usuario. Otra forma de cambiar el grupo es con `chgrp <group> <file/dir>`.

## Permisos especiales <a name="setuid"></a>

Se puede meter otro octeto de permisos, en la x, si la hay, s, si no la hay una S y en others... t si la hay y T si no la hay. Es decir, se enmascara la x (permiso de ejecución).
* Usuario y grupo: rwx --> rws, rw- --> rwS: Algo hay activo, si salen los standar, está inactivo.
* Otros: rwx --> rwt, rw- --> rwT: Algo hay activo, si salen los standar, está inactivo.

¿Qué es lo que se activa?
* Usuario: **setuid**
   * Carece de sentido en los directorios.
   * El proceso se ejecuta como el usuario propietario no como el que lo lanza.
   * ejemplo: passwd --> se ejecuta como usuario root.
* Grupo: **setgid**
   * Fichero: El archivo se ejecuta como el grupo propietario
   * Directorio: Directorios colaborativos, todos los fichros y directorios que se creen dentro tienen como propietario el grupo propietario, no el del usuario que lo creó.
   * Los permisos que se les suele dar a los directorios colaborativos son 2770
* sticky-bit:
   * No tiene sentido en ficheros.
   * No permite al usuario eliminar ficheros de los que no son propietarios.
   * Ejempo: /tmp cualquier usuario puede escribir en él, pero no puede borrar nada de lo que no sea propietario
   
Para asignar esto permisos se hace con chmod:
   * usuario: u+s
   * grupo: g+s
   * other: o+t
 localectl status
 En la notación octal, se añade otro dígito a la notación octal antes de los otros 3 dígitos.
 
## Máscaras <a name="umask"></a>

Cuando creamos un fichero, por defecto se nos crea con un grupo de permisos por defecto, que vienen definidos por una máscara.
Es una máscara en negativo, ed. 0027 --> Si pongo un 0, si se le da un 7, con la excepción de que no se le da ejecución si son ficheros.
* Genérico del sistema: /etc/profile ó /etc/bashrc  
* Para un usuario concreto: ~/.bash_profile ó ~/.bashrc  

Por seguridad no se dan permisos de ejecución por defecto a ningún fichero, hay que darle explícitamente el fichero de ejecución.

# Monitorización y administración de procesos <a name="proc"></a>

Un proceso es una instancia corriendo o lanzada de un programa ejecutable, consiste en:
* Espacio de direccines en memoria
* Propiedades de seguridad
* Una o mas hilos de ejecución
* Estado del proceso.

El entorno de un proceso incluye:
* Variables locales y globales.
* Constexto actual almacenado.
* Recursos reservados.

## Comandos <a name="proc_cmd"></a>

**ps**: 3 formatos de variables y un montón de flags.
   * - UNIX POXIX `ps -aux`
   * -- Extendidas de GNU `ps --aux`
   * (sin guion) BSD `ps aux`
   
Cada uno hace una cosa distinta.

**job** Está asociado a un pipeline entrado por la shell. No confundir con un proceso... Un job siempre se lanza desde una shell.
* Podemos tener lo que está en primer plano
* Lo que está en segundo plano.

Si un proceso no tiene asociado un terminal, (se muestra en el campo TTY del ps el signo **?**)
* Lanzar un proceso en segundo plano: `comando &` - al mandarlo, nos dará: __[job_id] PID__
* pasar un proceso a segundo plano: `comando + Ctrl-z`
* pasar a primer plano: `fg %<job_id>`, para conocer el número de job: `jobs`

~~~bash
[kiosk@foundation12 ~]$ sleep 100000 &
[1] 4619
[kiosk@foundation12 ~]$ jobs
[1]+  Running                 sleep 100000 &
[kiosk@foundation12 ~]$ fg %1
sleep 100000
^Z
[1]+  Stopped                 sleep 100000
[kiosk@foundation12 ~]$ jobs
[1]+  Stopped                 sleep 100000
[kiosk@foundation12 ~]$ ps -j
  PID  PGID   SID TTY          TIME CMD
 4565  4565  4565 pts/2    00:00:00 bash
 4619  4619  4565 pts/2    00:00:00 sleep
 4648  4648  4565 pts/2    00:00:00 ps
~~~
Si nos salimos de la shell, mataremos todos los jobs que estén en la shell, para prevenir esto está el comando `nohup <comando> &`

**TRUCO:** A veces en vez de hacer un bucle `while true; do clear; <comando>; sleep 2; done` será mejor ejecutar `watch -n 2 <comando>`

## Señales <a name="signals"></a>

Son interrupciones de SW enviadas al proceso.
Principales señales (OJO, los números de las señales, varian según la plataforma, por lo que se suele usar el nombre de la señal).
* **1 - SIGHUP** - _hangup_ Informa de la finalización de un proceso de un terminal.
* **2 - SIGINT** - Interrupción del teclado. (CTRL-c)
* **3 - SIGQUIT** - Como SIGINT pero genera un dump para depurar el proceso. (CTRL-\)
* **9 - SIGKILL** - No se puede bloquear, provoca una finalización abrupta del programa.
* **15 - SIGTERM** - Termina de forma ordenada, es la señal predeterminada.
* **18 - SIGCONT** - Resume un proceso que está detenido (statuso Stop), y lo vuelve a lanzar.
* **19 - SIGSTOP** - Suspende el proceso, no puede ser bloqueada o manejada
* **20 - SIGTSTP** - Suspende el proceso, pero se puede bloquear (CTRL-z)

Para la lista completa `kill -l`

Para enviar una señal a un proceso: `kill -<signal> <PID>`
Para enviar a varios:
* `killall -<signal> <patrón_comando>` - usando expresiones regulares
* `killall -<signal> <user> <patron_comando>` - Manda la señal a todos los comandos que cumplan el patrón del usuario especificado
* `pkill` Permite usar creterio mas avanzados de selección_
   * _-U <UID>_ - para usuario
   * _-G <GUID>_ - para grupo
   * _-P <PPID>_ - mata a los hijos del proceso padre
   * _-t <terminal>_ - mata los procesos del terminal
   
Si queremos ver los usuarios de un terminal:
* `who`
* `w` --> Nos da mas información. (ver la ayuda).
* `pstree [PID|user]` - muestra el arbol de procesos del usuario o del proceso
* `pgrep ` para mostar procesos con búsquedas más avanzadas.

## Monitorización de procesos <a name="proc_monitoring"></a>

Comando `top` 
Comando `uptime` -- Número de procesos, tiempo levantado y carga
Comando `w`--> Informa de procesos de usuario

### Promedios de carga.

Nos los da el top o el uptime., si dividimos la carga por el número de cpus, y es >1, el sistema está sobrecargado.

Sistemas por debajo de 1 es raro que tengan esperas.

Por encima de 1, hay que analizar qué es lo que está pasando... si estoy paginando (las escrituras son caras en cuanto a la carga), si la red nos lastra, etc... 

### campos del TOP
VIRT --> se corresponde con (VSZ del ps).
RES --> MEmoria física (RSS en ps)
TIME --> Tiempo de CPU
S --> Estado del proceso

Shift+p --> te lo ordena por consumo de procesador
Shift+m --> te lo ordena por consumo de memoria

# Control de servicios y demonios <a name="systemd"></a>

* **systemd** es el análogo al **init** de versiones anteriores.
   * controla los arranques de servicios y demonios del sistema.
   * su PID es 1 (tanto en systemd -RHEL7- y en init -RHEL6 y anteriores).
* **Demonio** procesos que realizan tareas y se ejecutan en segundo plano.
   * Suelen acabar con la letra _d_
   * Cuando quieren tener comunicación con otras partes del sistema, levanta un socket de systemd, o puede systemd levantar el socket y concederlo al demonio al que le toque, hasta que no tiene socket asignado, el daemos está aislado.
* Un **servicio** hace referencia a uno o varios procesos daemon corriendo en el sistema.

Todo esto no quita que haya cosas que se puedan contralar con **service** pero es un _legacy_.

Que nos proporcina systemd:
* Capacidades de paralelización en el arranque.
* Inicio bajo demanda de los servicios.
* Puede agrupar daemos relacionados.

## Comando _systemctl_ <a name="systemctl"></a>

* Ayuda: `systemctl -t hel`
* consulta de estado: `systemctl [-l] <daemon>`

Systemctl administra Unidades, 3 tipos:
* **.service** - hacen referencia a un servicio del sistema
* **.sockets** - comunicación interprocesos (IPC - semáforos)
   * desde el socket, podemos levantar el servicio bajo demanda y poner en escucha la unidad que le toque
   * como ejemplo _cups_
* **.path** - hacen referencia a la posibilidad de levantar/activar un servicio en función de si se ha dejado un fichero en una ruta.

**NOTA:** Cuidado con para una unidad porque el path y el socket pueden activarlo.
Para ver el estado: `systemctl status name.type`  
Estados: 
   * loaded.
   * enabled, disabled, static (este no se puede inciar de forma manual).
   * active (runing, exited, waiting, inactive)

### Usos

* Comprobar si un servicio está activo: `systemctl is-active name.type`
* Comprobar si está preparado para ejecutarse en el inicio: `systemctl is-enabled name.type`
* Listar estado de los servicios `systemctl list-units --type=service` Nos muestra las activas, con _-all_ muestra todas, incluidas las inactivas.
* Ver las configuraciones: `systemctl list-unit-files --type=service`
* Servicios que han fallado: `systemctl --failed --type=service`
* Parar un servicio: `systemctl stop name.type`, pero ojo, si siguen activos el .socket y el .path, todavía estos pueden levantar el servicio, si no queremos que se levante, `systemctl disable name.type`
* **Controlar los servicios**:
   * status
   * start
   * stop
   * restart
   * reload (reinicio "gracefull")
   
 #### Dependencias de unidades
 
`systemctl list-dependencies unit` Muestra las dependencias de la unidad, es decir, las unidades que la unidad en cuestión necesita para levantar.
`systemctl list-dependencies unit --reverse` Lista las unidades que dependen de nuestra unidad.

#### Enmascaramiento

Para que ni el sistema ni un usuario levanten un servicio, se les enmascara, de forma que se borra el link simbólico que apunta al servicio, así nos aseguramos de que nadie accidentalmente nadie arranca el servicio.

Esto lo podemos hacer para que no podamos levantar dos servicios que entran en conflicto (como por ejemplo, network vs. NetworkManager, o iptables vs. firewalld).

`systemctl [mask|umask] <unit>` Una vez hecho esto, no podrá arrancar bajo ningún concepto.
