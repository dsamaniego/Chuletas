# TPT arranque de las piezas de Control-M

Arraque automático de los agentes de Control-M en los nodos TPT.

**Problema**: Ahora mismo no están arrancando los agentes de control-M cuando se reinicia la máquina, hay que pensar cómo meterlo para que se arranquen de forma automática en los reinicios.

## Inicio manual de los agentes de Control-M
1. Nos logamos en el agente TPT en cuestión.
2. Escalamos privilegios
3. Ejecutamos el script de arranque: '/usr/local/pr/ctmagent/ctm/scripts/start-ag'
    - Nos preguntará el usuario: (xpctma1)

## Inicio automático en el arranque del nodo TPT.
Creamos un script de inicio automatico:
~~~ bash
#! /bin/sh
#
# init_ctmag
# 
# Usuario: xpctma1
# Opcion ALL
#

case "$1" in
start)
echo "Starting Control-M agents ... "
/usr/local/pr/ctmagent/ctm/scripts/start-ag -u xpctma1 -p ALL
;;
stop)
echo "Stopping Control-M agents ..."
/usr/local/pr/ctmagent/ctm/scripts/shut-ag -u xpctma1 -p ALL
;;
*)
echo "Script usage: /etc/init.d/init_ctmag {start|stop}"
exit 1
;;
esac
exit 0
~~~

Lo metería en rc2.d, rc3.d, rc4.d y rc5.d como S90ctmag y en rc0.d y rc6.d como K10ctmag

Hay que incluirlo en el playbook de ansible para Iluvatar y pasarlo al equipo PE (Product Engeneering).
