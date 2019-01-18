# Despliegue de soyuz 1.5.3

## Cursl útiles.

#### Comprobar plantilla cargada
```curl -u oper https://soyuz.marathon.l4lb.$(dnsdomainname)/v1/components/crossdata/2.11.1-0.13.2.3```

#### Eliminar plantilla cargada
```curl -X DELETE -u oper https://soyuz.marathon.l4lb.$(dnsdomainname)/v1/components/crossdata/2.11.1-0.13.2```

#### Subir plantilla
```curl -X POST -u oper -H "Content-Type: application/json" -X POST --data-binary "@component.json" https://soyuz.marathon.l4lb.$(dnsdomainname)/v1/components```
