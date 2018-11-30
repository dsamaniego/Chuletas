## Regenerar la red de los servidores.
```
for i in  $(ansible -m shell -b -a "ping -c 1 -W 1 hddaasapi.sces1p100.isi" dcos_agent_private | grep FAILED | awk -F ' ' '{ print $1 }'); do
port=$(nova interface-list $i | grep <ID_red> | awk -F '|' '{ print $3 }')
echo $i
nova interface-detach $i $port
nova interface-attach --net-id <ID_red> $i
done
```

