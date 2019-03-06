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

#### Forma alternativa

Desde gosec1,2,3 con CLI:
1. `export VAULT_ADDR=https://vault.service.eos.$(dnsdomainname):8200`
2. `vault auth -method=ldap username=XE*****`
3. Introducir contraseña de ldap
4. Operar normalmente (vault read, vault list, vault write...)


### Desde cualquier agente con la API:

1. Conseguimos el token: 
    ~~~ bash
    export TOKEN=$(curl -s --request POST --data '{"password":"'$(cat mipass_work_es)'"}' https://vault.service.eos.$(dnsdomainname):8200/v1/auth/ldap/login/$(whoami) | jq -r .auth.client_token)
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

## Levantar los gosec.
Cuando arranquemos los gosec después de una parada, tendremos que dessellar vault... lo primero, tenemos que comprobar que el servicio de vault esté levantado, en caso de que no lo esté suele ser porque no ha levantado el zookeeper, en cuyo caso es porque se ha quedado tostado todo.

Lo mejor es reiniciar el NetworkManager, con esto debería levantar todo, en todo caso, habrá que levantar a mano vault (mejor con start -- stop que con restart).

Una vez levantado, desde el contenedor de ilúvatar ya podremos lanzar el playbook de sellado:
~~~ bash
[root@daas-global-priv-01 ansible]# touch /environment/.inventory_cache && ansible-playbook operations/unseal_vault.yml 

PLAY [gosec] **********************************************************************************************************************************************************************************************************************************

TASK [tools/vault/unseal-vault : include_tasks] ***********************************************************************************************************************************************************************************************
included: /datio/iluvatar/deployer/ansible/roles/tools/vault/unseal-vault/tasks/start.yml for gosec3, gosec2, gosec1

TASK [tools/vault/unseal-vault : Ensure vault is started] *************************************************************************************************************************************************************************************
ok: [gosec2]
ok: [gosec1]
ok: [gosec3]

TASK [tools/vault/unseal-vault : Wait for Vault] **********************************************************************************************************************************************************************************************
ok: [gosec1]
ok: [gosec3]
ok: [gosec2]

TASK [tools/vault/unseal-vault : include_tasks] ***********************************************************************************************************************************************************************************************
 [WARNING]: Ignoring invalid attribute: deplay

included: /datio/iluvatar/deployer/ansible/roles/tools/vault/unseal-vault/tasks/unseal.yml for gosec3, gosec2, gosec1

TASK [tools/vault/unseal-vault : Load Vault tokens from file] *********************************************************************************************************************************************************************************
ok: [gosec3]
ok: [gosec2]
ok: [gosec1]

TASK [tools/vault/unseal-vault : Check if Vault is sealed] ************************************************************************************************************************************************************************************
ok: [gosec1]
ok: [gosec2]
ok: [gosec3]

TASK [tools/vault/unseal-vault : Unseal vault] ************************************************************************************************************************************************************************************************
skipping: [gosec3] => (item=None) 
skipping: [gosec3] => (item=None) 
skipping: [gosec3] => (item=None) 
skipping: [gosec3]
skipping: [gosec1] => (item=None) 
skipping: [gosec1] => (item=None) 
skipping: [gosec1] => (item=None) 
skipping: [gosec1]
ok: [gosec2] => (item=None)
ok: [gosec2] => (item=None)
ok: [gosec2] => (item=None)
ok: [gosec2]

TASK [tools/vault/unseal-vault : Wait until Vault is oprerative] ******************************************************************************************************************************************************************************
skipping: [gosec3]

PLAY RECAP ************************************************************************************************************************************************************************************************************************************
gosec1                     : ok=6    changed=0    unreachable=0    failed=0   
gosec2                     : ok=7    changed=0    unreachable=0    failed=0   
gosec3                     : ok=6    changed=0    unreachable=0    failed=0   
~~~
