# Auth en vault con LDAP

Se ha habilitado el acceso a vault a través de login con ldap, de momento está en pruebas en work01es y priv02gl.

export TOKEN=$(curl -s --request POST --data '{"password":"'$(cat mipass_work_es)'"}' https://vault.service.eos.$(dnsdomainname):8200/v1/auth/ldap/login/$(whoami) | jq -r .auth.client_token)

Os paso resumen con la operativa para login con ldap:

Desde gosec1,2,3 con CLI:
1.- # export VAULT_ADDR=https://vault.service.eos.$(dnsdomainname):8200
2.- # vault auth -method=ldap username=USUARIO
3.- Introducir contraseña de ldap
4.- Operar normalmente (vault read, vault list, vault write...)

Desde cualquier agente con la API:
1.- # export PASSWORD="PASSWORD DEL USUARIO DE LDAP"

2.- # Para leer secretos:
curl -s  --request GET -H "X-Vault-Token: $(curl -s --request POST --data '{"password":"'${PASSWORD}'"}' https://vault.service.eos.$(dnsdomainname):8200/v1/auth/ldap/login/$(whoami) | jq -r '.auth.client_token')" https://vault.service.eos.$(dnsdomainname):8200/v1/PATH/DE/VAULT/AL/SECRETO | jq -r '.data'

Example:
curl -s  --request GET -H "X-Vault-Token: $(curl -s --request POST --data '{"password":"'${PASSWORD}'"}' https://vault.service.eos.$(dnsdomainname):8200/v1/auth/ldap/login/$(whoami) | jq -r '.auth.client_token')" https://vault.service.eos.$(dnsdomainname):8200/v1/platform/es/dev/datio/fajita/fajita/certificate/server | jq -r '.data'

3.- # Para listar secretos:
curl -s --request LIST -H "X-Vault-Token: $(curl -s --request POST --data '{"password":"'${PASSWORD}'"}' https://vault.service.eos.$(dnsdomainname):8200/v1/auth/ldap/login/$(whoami) | jq -r '.auth.client_token')" https://vault.service.eos.$(dnsdomainname):8200/v1/PATH/DE/VAULT | jq -r '.data.keys'

Example:
curl -s --request LIST -H "X-Vault-Token: $(curl -s --request POST --data '{"password":"'${PASSWORD}'"}' https://vault.service.eos.$(dnsdomainname):8200/v1/auth/ldap/login/$(whoami) | jq -r '.auth.client_token')" https://vault.service.eos.$(dnsdomainname):8200/v1/platform/es/dev/datio/fajita/ | jq -r '.data.keys'

He intentado simplificar al máximo las llamadas a la api para que sea lo más sencillo posible, si tenéis cualquier duda decidme.

Saludos.
￼
Para evitar escribir nuestra contraseña y que se vaya al audit de sebasshtian, la idea es tener un fichero con nuestra clave en local:
echo $(read -s MYPASS; echo $MYPASS > mipass_work_es) # Nos pregunta la contraseña y la escribe en el fichero mipass_work_es

Copiar el fichero al entorno:
scp mipass_work_es E053493@agent-1@ssh.daas.work.es.ether.igrupobbva:

Conseguir el token:
export TOKEN=$(curl -s --request POST --data '{"password":"'$(cat mipass_work_es)'"}' https://vault.service.eos.$(dnsdomainname):8200/v1/auth/ldap/login/$(whoami) | jq -r .auth.client_token)

Operar con el token:
curl -s --request LIST -H "X-Vault-Token: ${TOKEN}" https://vault.service.eos.$(dnsdomainname):8200/v1/ca-trust/certificates | jq -r .data.keys

Si necesitamos escribir alguna clave la idea es la misma. Escribirlas en un fichero local, copiarlo al entorno y desde allí hacer source del fichero. Una vez las tenemos como variables de entorno, podemos escribirlas sin necesidad de mostrarlas.

## De donde sacar el token de root.

En los contenedores de ilúvatar de cada entorno, está en `/environment/pass/vault/vault_secrets.yml`