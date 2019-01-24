# Copiar ficheros de piezas.

* Si podemos llegar a DCOS sin fireglass, simplemente podemos ir a la pieza en cuestión, abrirla, ir a files y descargar los ficheros que necesitemos.
* Si no podemos deshacernos del fireglass tendremos que hacer un pequeño rodeo:
    1. Nos vamos a DC/OS y buscamos la pieza:
    2. Nos metemos en la pieza y vemos en que agente se ejecuta por ssh (o como sea):
    3. Nos conectamos a mesos, buscamos la pieza y pinchamos en el link de sandbox.
    4. Al desplegarse, en la parte de arriba nos viene la ruta donde se encuentran los ficheros de la pieza.
    5. En la terminal, nos vamos a ese directorio, arrancamos el logger del terminal y hacemos un cat al fichero que queremos copiar.
    6. Cuando termine el cat, paramos el logger.
    7. Con esto ya tenemos en nuestro local el fichero que queremos descargar.
    