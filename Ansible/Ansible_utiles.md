# Utilidades de Ansible

Todo esto se tiene que hacer desde el contenedor de Ilúvatar.
Siempre que vayamos a lanzar un playbook o un ansible conviene que toquemos el inventario dinámico para que no se eternice:
```bash
touch /environment/.inventory_cache && <comando_ansible>
```
## Regenerar el inventario dinámico

```./ansible_hosts -l```

## Regenerar la red de los servidores.
```bash
for i in  $(ansible -m shell -b -a "ping -c 1 -W 1 hddaasapi.sces1p100.isi" dcos_agent_private | grep FAILED | awk -F ' ' '{ print $1 }'); do
port=$(nova interface-list $i | grep <ID_red> | awk -F '|' '{ print $3 }')
echo $i
nova interface-detach $i $port
nova interface-attach --net-id <ID_red> $i
done
```

## Reiniciar metronome en los master

`ansible -m shell -b -a "systemctl restart dcos-metronome"  dcos_master`
