# Bash
## Links
[https://www.gnu.org/software/bash/] 
* Hacer bucles con cadenas: [https://linuxhint.com/bash_loop_list_strings/]
* Limitar uso de CPU: [https://linuxhint.com/limit_cpu_usage_process_linux/] 
* Chequear uso de memoria: [https://linuxhint.com/check_memory_usage_process_linux/] 
* Explicacion de la carga de una máquina: [http://blog.scoutapp.com/articles/2009/07/31/understanding-load-averages] *Resumen* Si la carga es mayor que el número de procesadores, mal.. lo ideal es que: 'carga <= 0.7*num_procesadores' 

## Comandos útiles
### jq
Este comando es para poder visualizar y filtrar las salidas de comandos en formato json.
Nos saca los PIDs del fichero ejemplo.json:

    *[{"exec_time": "2137811", "status": 1, "pid": "12947"}, {"exec_time": "2137741", "status": 1, "pid": "13702"}, {"exec_time": "2137700", "status": 1, "pid": "14443"}, {"exec_time": "2154915", "status": 1, "pid": "14845"}, {"exec_time": "2154720", "status": 1, "pid": "15839"}, {"exec_time": "2153510", "status": 1, "pid": "18062"}, {"exec_time": "2153450", "status": 1, "pid": "18834"}]*

```
cat ejemplo.json | jq '.[]| {pid}'|grep pid|awk -F "\"" '{ print $4 }'
12947
13702
14443
14845
15839
18062
18834
```
### Ver los logs de un servicio.
`# journalctl -fu <servicio>`
