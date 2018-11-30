# Tipología de alertas.

## hdfsclient sin espacio en /
Revisar los ```/home``` de los usuarios que suelen dejar ficheros grandes en sus directorios de trabajo. En teoría, estos directorios serían para que dejasen ahí cosas que van a usar en sus ingestas, pero que tienen que pasar al Isilon, y sólo deberían estar ahí temporalmente.

Lo mismo sería una buena idea tener un job que hiciese un barrido de esos directorios y hacer limpieza.

