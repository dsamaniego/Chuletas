# Tabla de contenidos
0. [Introducción al curso](#introduccion)
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

# Introducción al curso <a name="introduccion"></a>
[kiosk@foundation12 ~]$ find /etc -name passwd 2> /dev/null |tee /dev/pts/1 > ~/encontrados4.txt

#### Máquinas

* Máquina: **foundation12** (172.25.254.12 - 172.25.12.1), user: kiosk / lamia
* Máquinas virtuales:
  * **desktop12** (172.15.12.10): student/student - root/redhat
  * **server12** (172.15.12.11): student/student - root/redhat
* Máquina del profe: **classroom** (172.25.0.254)

#### Controlar las máquinas virtuales

Programa `rht-vmctrl`, opciones:
* reset -- restaura la máquina hasta el último snapshot guardado
* view -- abre la consola
* start -- arranca la VM
* save -- hace el snapshot
* fullreset -- vuelve la VM al origen de los tiempos.

#### Opciones de lenguaje

* Si accedemos a la máquina por ssh: `loadkeys es` (se pierde cada vez que se reinicie la máquina).
* Podemos tocar a mano el fichero `/etc/vconsoles.conf`
* La manera más cómoda es cambiarlo en el entorno gráfico.

# Acceso a la línea de comandos <a name="consola"></a>

## Entorno gráfico <a name="graphic_console"></a>

El entorno gráfico por defecto en RHEL7 es Gnome3, que corre sobre XWConceptos<a name="file_conceptsindow. Tiene dos modos: _classic_ y _modern_.

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

## Manejo de ficheros<a name="file_mngmt"></a>

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
7. $HOME: directorio raíz del usuario
8. shell del usuario (podemos tener o `/sbin/nologin` -para evitar que el usuario no haga login ,por ejemplo, si va a usar servicios del sistema pero no necesita acceso a la shell de sistema ni manipular ficheros del sistema; o `/bin/false`, si no queremso que use nada de nuestro sistema).

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

Añadir un grupo: `groupadd [-g <GID>] <nombre_gr>`, si no le ponemos GID, nos da el siguiente GID de los grupos que no son del sistema.
Renombrar un grupo: `groupmod -n <nombre_nuevo> <nombre_antigüo>`
Cambiar el GID: `groupmod -g <nuevo_GID> <nombre_gr>`
Borrar grupo: `groupdel <grupo>`, lo que vale para el borrado de usuarios, vale para los grupos. Más ojo todavía porque puede haber varios usuarios 

Si queremos cambiar el grupo principal a un usuario: `usermod -g <grupo> <username>`
Si queremos añadir grupos secundarios: `usermod -aG <lista_secundarios> <username>`, si no ponemos el -a, sustituiremos los grupos secundarios que tenga por los nuevos.



