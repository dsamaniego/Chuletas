# Ilúvatar

Ilúvatar es el instalador de la plataforma, tanto la de Datio como la de Stratio.

Provee una capa que recubre al instalador de Stratio (eos-installer) y la securiza.

Ilúvatar se ejecuta en un docker dentro de los ID2 (dependiendo de donde vayamos a hacer la intervención será en un sitio u otro).

1. Tendremos que ir haciendo los cambios en el descriptor de Ilúvatar para pasar de la versión que haya a la versión a la que queremos ir (está en el GIT).
2. Comentamos las entradas de userland del fichero **datio.yml** y además lo renombramos a **datio.yml_no** para que no se ejecute. (la parte de userland sólo se deja sin descomentar para instalaciones limpias).
3. Nos conectamos al docker de Ilúvatar y lanzamos el instalador de Ilúvatar con el chequeo de infraestructura de Terraform (`python -m iluvatar -c -p`) para que simplemente chequee Terraform pero no haga ningún cambio, si todo va bien, luego lo lanzamos sin "-p".
4. Ahora ya lanzamos Ilúvatar para que Terraform cree la infraestructura que falte (`python -m iluvatar -c`).
5. Nos vamos al directorio `/datio/deployer/ansible/` que es donde están los playbooks de ansible,
5.1. Lanzamos la actualización de Ilúvatar (de la que estamos a la que queremos llegar, si hay que lanzar varias, habrá que hacerlo en serie):
~~~ bash
touch /environment/.inventory_cache; ansible-playbook migrations/2.4.3_to_2.5.0.yml
~~~
5.2. Luego lanzamos la del instalador de EOS (de la versión que estamos a la que queremos llegar):
~~~ bash
touch /environment/.inventory_cache; ansible-playbook migrations/eos_0.12.10_to_0.12.17.yml
~~~

  Para controlar que todo va bien, nos conectamos al bootstrap donde esté el instalador de EOS (donde esté es STRATIO_VOLUME), nos conectamos con `ssh -F ssh_config bootstrap-<n>` y ahí vemos los logs del instalador:
  ~~~ bash
  while true
  do
  sudo docker logs --tail -f 10 eos-installer
  done
  ~~~
6. Renombramos el fichero **datio.yml_no** a **datio.yaml** y lanzamos el playbook `ansible-playbook datio.yml` para que termine de actualizar el Ilúvatar.
Si queremos controlar cómo va la ejecución: `docker logs --tail 10 -f <id_iluvatar>`
7. Securizamos mesos: Se ha editado la última linea del fichero *roles/eos/tasks/securize-mesos.yml* para modificar las condiciones del when:
  ~~~ bash
  #when: mesos_sec_descriptor_file`.stat.exists and mesos_sec_descriptor.changed
  when: mesos_sec_descriptor_file.stat.exists
  ~~~
Y lanzamos el tag de mesos_securize `ansible-playbook datio.yml -t eos-securize-mesos`

Con esto, ya hemos acabado, ahora sólo falta comprobar que todo va bien conectándonos al DCOS y creando un proyecto de intelligence (eso ya se verá como)