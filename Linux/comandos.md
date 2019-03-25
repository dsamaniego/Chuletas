# Tabla de contenidos

1. [Internacionalización](#intennacionalizacion)
   1. [Opciones de lenguaje](#language)

# Internacionalización <a name="internacionalizacion"></a>

Control de la configruación de gnome: `gnome-control-center`. Entre otras tiene las siguientes opciones.
* _region_: Establece las opciones de región y lenguaje (incluidos formatos).
* _datetime_: Establece opciones de fecha y hora.

## Opciones de lenguaje <a name="language"></a>

La configuración del lenguaje de cada usuario en gnome se guarda en: /var/lib/AccountService/users/${USER}
Para establecer un lenguaje para un comando:
* `$ LANG=<codigo> <comando>`, con de código es uno de los admitidos 
* `localectl list-locales`, muestra todos los códigos