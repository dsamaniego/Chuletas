# Bash

## Links
[https://www.gnu.org/software/bash/] 
* Hacer bucles con cadenas: [https://linuxhint.com/bash_loop_list_strings/]
* Limitar uso de CPU: [https://linuxhint.com/limit_cpu_usage_process_linux/] 
* Chequear uso de memoria: [https://linuxhint.com/check_memory_usage_process_linux/] 
* Explicacion de la carga de una máquina: [http://blog.scoutapp.com/articles/2009/07/31/understanding-load-averages] *Resumen* Si la carga es mayor que el número de procesadores, mal.. lo ideal es que: 'carga <= 0.7*num_procesadores' 

## Comandos útiles

### Ver los logs de un servicio.

`journalctl -fu <servicio>`

### Quitar las extensiones de ficheros

`for i in *.ext; do mv $i $(echo $i|awk -F '.' '{ print $1 }'); done`
