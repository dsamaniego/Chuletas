# DNSmasq con VPNaaS

Este documento es una guía para configurar el pc usando VPNaaS (desde oficina Datio, explicación más adelante).

## Forticlient

Al levantar el túnel punto a punto con Forticlient automáticamente pone ruta como defecto para que todo el tráfico vaya por el túnel y actualiza el fichero /etc/resolv.conf para utilizar los servidores DNS del banco. Esto implica tener que utilizar el proxy del BBVA, lo cual origina un problema al usar la línea de comandos en nuestro pc, entre otros problemas derivados de esta configuración.

> **_OPCIONAL_**
> Si se quiere utilizar el proxy del BBVA y poder usar todas las herramientas instaladas en el pc, se puede instalar cntlm que hará de proxy local autenticado con el proxy corporativo NTLM. En el enlace https://www.howtoforge.com/linux-ntlm-authentication-proxy-isa-server-with-cntlm podemos encontrar cómo > configurar cntlm.

## DNSmasq

> _Esta configuración está probada únicamente en Ubuntu 16.04 LTS_ 

DNSmasq es un servidor DHCP y DNS ligero. La utilidad que nos aporta con la VPNaaS es poder utilizar la VPN sin necesidad de pasar por el proxy todo nuestro tráfico a Internet. 

Esta herramienta junto a un pequeño script que modifica las rutas por defecto al levantar el túnel nos permitirá conectarnos a la red del banco por el túnel y el resto del tráfico irá por el pfSense. 

Pasos para configurar el pc:
- Modificar el fichero `/etc/NetworkManager/NetworkManager.conf`:
    [main]
    plugins=ifupdown,keyfile,ofono
    dns=dnsmasq
    [ifupdown]
    managed=false
- Reinicar NetworkManager: `$sudo systemctl restart network-manager`.
- Instalar dnsmasq: `$sudo apt-get install dnsmasq`.
- Modificar el fichero _/etc/dnsmasq.conf_ con la siguiente configuración:
    port=53
    domain-needed
    bogus-priv
    no-poll
    server=/igrupobbva/10.51.33.33
    server=/igrupobbva/10.48.33.33
    server=172.16.12.1
    listen-address=127.0.0.1
    > El server=172.16.12.1 es pfSense, que hace de DNS para todo lo que no es igrupobbva. Si nos conectamos desde otro sitio (ejemplo, en casa) hay que poner tu DNS/router como server. (Ejemplo: server=192.168.1.1)
- Reinicar dnsmasq: `$sudo systemctl restart dnsmasq`.
- Comprobar el servicio y ver la salida del comando `$ sudo systemctl status dnsmasq`.
    Nov 15 08:49:35 fperea-Inspiron-5570 dnsmasq[30666]: using nameserver 10.51.33.33#53 for domain ether.igrupobbva
    Nov 15 08:49:35 fperea-Inspiron-5570 dnsmasq[30666]: read /etc/hosts - 7 addresses
    Nov 15 08:49:35 fperea-Inspiron-5570 dnsmasq[30666]: using nameserver 172.16.12.1#53
    Nov 15 08:49:35 fperea-Inspiron-5570 dnsmasq[30666]: using nameserver 10.48.33.33#53 for domain iaas.igrupobbva
    Nov 15 08:49:35 fperea-Inspiron-5570 dnsmasq[30666]: using nameserver 10.51.33.33#53 for domain iaas.igrupobbva
    Nov 15 08:49:35 fperea-Inspiron-5570 dnsmasq[30666]: using nameserver 10.48.33.33#53 for domain nextgen.igrupobbva
    Nov 15 08:49:35 fperea-Inspiron-5570 dnsmasq[30666]: using nameserver 10.51.33.33#53 for domain nextgen.igrupobbva
    Nov 15 08:49:35 fperea-Inspiron-5570 dnsmasq[30666]: using nameserver 10.48.33.33#53 for domain ether.igrupobbva
    Nov 15 08:49:35 fperea-Inspiron-5570 dnsmasq[30666]: using nameserver 10.51.33.33#53 for domain ether.igrupobbva
    Nov 15 08:49:37 fperea-Inspiron-5570 systemd[1]: Started dnsmasq - A lightweight DHCP and caching DNS server.

## VPNaaS

El pc ya está configurado. Procedemos a levantar el túnel con Forticlient (recomiendo instalar el .deb para no tener que levantar el túnel desde el terminal, enlace https://hadler.me/files/forticlient-sslvpn_4.4.2333-1_amd64.deb).


Crear un script (recordad el directorio, este script hay que lanzarlo cada vez que se levanta el túnel).
```bash
#!/bin/bash
IP=$(ip r | grep ppp0 | awk '{print $3}')
ip route del default via $IP
ip route add 10.0.0.0/8 dev ppp0
data=$'namerserver 127.0.0.1\nsearch es.datio'
echo "$data" > /etc/resolv.conf
```
Y lanzar con sudo este script: `$ sudo bash script.sh`
