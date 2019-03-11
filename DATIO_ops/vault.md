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

Por ese orden.
1. paro vault
2. paro zookeper-gosec
3. arranco zookeper-gosec
4. arranco vault
5. me conecto a Iluvatar y desello con el playbook ()