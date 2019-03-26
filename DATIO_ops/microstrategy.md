# Microstrategy

## Configurar los iserver para que guarden los cores.

Viene de la incidencia: DSD-25158
Mirar el siguiente [documento](https://community.microstrategy.com/s/article/KB13610-System-settings-to-check-to-ensure-that-core-files-for?language=en_US). Hay que hablar con PE para ver cómo implementarlo.

## Cargar plugins

Por ejemplo para cargas imágenes o fuentes nuevas.
Mirar el siguiente [documento](https://community.microstrategy.com/s/article/Animated-Bubble-Charts?language=en_US)

Hay que meterlo y descomprimirlo en los 3 iservers en la ruta: `/home/tomcat/webapps/MicroStrategy/plugins`

Cambiar el propietario:   
`chown -R tomcat:tomcat <ruta_plugin>`

Para que tome los cambios hay que reinciar el docker del tomcat.

