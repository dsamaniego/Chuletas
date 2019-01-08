# Credenciales de Vault.

Para hacer consultas de vault en todos los entornos, simplemente nos conectamos al gosec2 y ahí buscamos en el histórico el export TOKEN...

## PLAY y WORK-ES
Aquí el procedimiento es distinto (buscar un correo con asunto: _Auth en vault con ldap_).

### Desde gosec1,2,3 con CLI:
1. Exportamos la url de vault: `# export VAULT_ADDR=https://vault.service.eos.$(dnsdomainname):8200`
2. Como nos estamos conectando por sebasstian y todo lo que escribimos queda registrado, lo mejor es tener un fichero en local **mypass_workes** o **mypass_play** con la contraseña de nuestro usuario XE dentro y copiarla al entorno que sea con sebasstian cada vez que necesitemos usar vault
    `./scripts/sebasshtian.sh ./mypass_workes gosec2@work.es:mypassword`
3. Adquirimos permisos para operar co vault: `# vault auth -method=ldap username=USUARIO -password=$(cat /home/XExxxxx/mypassword)`
4. Operar normalmente (vault read, vault list, vault write...)
5. Cuando dejemos de trabajar, borramos el fichero con la contraseña.

### Desde cualquier agente con la API:
1. Conseguimos el token: 
    ~~~ bash
    # export TOKEN=$(curl -s --request POST --data '{"password":"'$(cat mipass_work_es)'"}' https://vault.service.eos.$(dnsdomainname):8200/v1/auth/ldap/login/$(whoami) | jq -r .auth.client_token)
    ~~~
2. Operamos con el token:
    * Leer secretos:
    ~~~ bash
    curl -s  --request GET -H "X-Vault-Token: ${TOKEN}" https://vault.service.eos.$(dnsdomainname):8200/v1/auth/ldap/login/$(whoami) | jq -r '.auth.client_token')" https://vault.service.eos.$(dnsdomainname):8200/v1/PATH/DE/VAULT/AL/SECRETO | jq -r '.data'
    ~~~
    * Listar secreteos
    ~~~ bash
    curl -s --request LIST -H "X-Vault-Token: $(curl -s --request POST --data '{"password":"'${PASSWORD}'"}' https://vault.service.eos.$(dnsdomainname):8200/v1/auth/ldap/login/$(whoami) | jq -r '.auth.client_token')" https://vault.service.eos.$(dnsdomainname):8200/v1/PATH/DE/VAULT | jq -r '.data.keys'
    ~~~