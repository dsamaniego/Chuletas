# jq (JSON Query)

Con esta utilidad, podemos hacer consultas a un fichero JSON. Este comando es para poder visualizar y filtrar las salidas de comandos en formato json.

En general:
* json . --> se refiere a todo el objeto json
* json .[] --> Si el objeto es un array, a todos los elementos del array
* json .[3-6] --> Si el objeto es un array, a los elementos del 3 al 6
* json '.[]|{etiqueta}' --> Al elemento _etiqueta_ de cada elemento del array.

Esto podría ir descendiento en escala según profundizamos en el objeto JSON.

## Ejemplo

Dado el siguiente JSON:
~~~json
[{"exec_time": "2137811", "status": 1, "pid": "12947", "personas": [{"nombre":"Fern", "apellido":"Sahez"},{"nombre": "Antoni", "apellido":"Pes"}, {"nombre":"Pepe", "apellido":"tronco"}]}, {"exec_time": "2137741", "status": 1, "pid": "13702", "personas":[{"nombre":"Ppe", "apellido":"etronco"}]}, {"exec_time": "2137700", "status": 1, "pid": "14443", "personas":[]}, {"exec_time": "2154915", "status": 1, "pid": "14845", "personas":[]}, {"exec_time": "2154720", "status": 1, "pid": "15839", "personas":[]}, {"exec_time": "2153510", "status": 1, "pid": "18062", "personas":[]}, {"exec_time": "2153450", "status": 1, "pid": "18834", "personas":[{"nombre":"Fermin", "apellido":"Sanchez"},{"nombre": "Antonioa", "apellido":"Peres"}]}]
~~~

Si queremos verlo en formato "amigable":

~~~json
jhicar@jhicar:~/bin$ cat ejemplo.json|jq 
[
  {
    "exec_time": "2137811",
    "status": 1,
    "pid": "12947",
    "personas": [
      {
        "nombre": "Fern",
        "apellido": "Sahez"
      },
      {
        "nombre": "Antoni",
        "apellido": "Pes"
      },
      {
        "nombre": "Pepe",
        "apellido": "tronco"
      }
    ]
  },
  {
    "exec_time": "2137741",
    "status": 1,
    "pid": "13702",
    "personas": [
      {
        "nombre": "Ppe",
        "apellido": "etronco"
      }
    ]
  },
  {
    "exec_time": "2137700",
    "status": 1,
    "pid": "14443",
    "personas": []
  },
  {
    "exec_time": "2154915",
    "status": 1,
    "pid": "14845",
    "personas": []
  },
  {
    "exec_time": "2154720",
    "status": 1,
    "pid": "15839",
    "personas": []
  },
  {
    "exec_time": "2153510",
    "status": 1,
    "pid": "18062",
    "personas": []
  },
  {
    "exec_time": "2153450",
    "status": 1,
    "pid": "18834",
    "personas": [
      {
        "nombre": "Fermin",
        "apellido": "Sanchez"
      },
      {
        "nombre": "Antonioa",
        "apellido": "Peres"
      }
    ]
  }
]
~~~

Si queremos sacar los PIDs
~~~bash
cat ejemplo.json | jq '.[]| {pid}'|grep pid|awk -F "\"" '{ print $4 }'
12947
13702
14443
14845
15839
18062
18834
~~~

Si queremos sacar las personas:
~~~bash
jhicar@jhicar:~/bin$ cat ejemplo.json|jq '.[].personas'
[
  {
    "nombre": "Fern",
    "apellido": "Sahez"
  },
  {
    "nombre": "Antoni",
    "apellido": "Pes"
  },
  {
    "nombre": "Pepe",
    "apellido": "tronco"
  }
]
[
  {
    "nombre": "Ppe",
    "apellido": "etronco"
  }
]
[]
[]
[]
[]
[
  {
    "nombre": "Fermin",
    "apellido": "Sanchez"
  },
  {
    "nombre": "Antonioa",
    "apellido": "Peres"
  }
]
~~~

Si queremos ver tiempo de ejecución y PID:

Con etiquetas:
~~~bash
jhicar@jhicar:~/bin$ cat ejemplo.json|jq '.[]|{exec_time,pid}'
{
  "exec_time": "2137811",
  "pid": "12947"
}
{
  "exec_time": "2137741",
  "pid": "13702"
}
{
  "exec_time": "2137700",
  "pid": "14443"
}
{
  "exec_time": "2154915",
  "pid": "14845"
}
{
  "exec_time": "2154720",
  "pid": "15839"
}
{
  "exec_time": "2153510",
  "pid": "18062"
}
{
  "exec_time": "2153450",
  "pid": "18834"
}
~~~

Sin etiqueteas:
~~~bash
jhicar@jhicar:~/bin$ cat ejemplo.json|jq '.[]|.exec_time,.pid'
"2137811"
"12947"
"2137741"
"13702"
"2137700"
"14443"
"2154915"
"14845"
"2154720"
"15839"
"2153510"
"18062"
"2153450"
"18834"
~~~