# Vault

## gosec-sso

### Error gosec-sso error al entrar en dcos

1. En los nodos auth:
    inciar kinit y krb5kdc
2. Iniciar gosec-sso en el leader.mesos

### No hacemos login con Stratio

Si al meter usuario y password en el login de Stratio no nos loga y no nos dice nada, probar a meter contraseña mala, si nos devuelve:  
_"The login and password does not match to an active account"_

Reiniciamos gosec-sso en todos los master.

## Alertas de consul.

root@agent-1 PLAY01 cloud-user]# curl  http://agent-1.node.eos.$(dnsdomainname):8500/v1/health/node/agent-1 -I
HTTP/1.1 200 OK
Access-Control-Allow-Origin: *
Content-Type: application/json
X-Consul-Index: 12168947
X-Consul-Knownleader: true
X-Consul-Lastcontact: 0
Date: Tue, 04 Dec 2018 09:41:45 GMT

En el caso , que el código respuesta sea distinto a 200, lanzaremos la acción reactiva.

restart_service.yml

## Reinicio de la máquinas gosec

Normalmente si está todo jodido, suele ser o por el NTP o por el NetworkManager, así que normalmente con reiniciarlo normalmente bastará para que arranquen todas las piezas (menos seguramente vault). 

Si hay que hacerlo a mano.
- Si tenemos parado kafka, primero habrá que reiniciar zookeeper-kafka, con esto, levantará kafka casi seguro.
- Despues arrancaremos zookeeper-gosec

Seguimos con los arranques en el punto 3.

Por ese orden.
1. paro vault
2. paro zookeper-gosec
3. arranco zookeper-gosec
4. arranco vault
5. me conecto a Iluvatar y desello con el playbook ([root@daas-usa-live-01 ansible]# touch /environment/.inventory_cache && ansible-playbook ./operations/unseal_vault.yml )


