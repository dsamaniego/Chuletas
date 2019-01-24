# Desarrollo de playbooks de Ansible
Si vamos a hacer algún playbook para una funcionalidad nueva:
1. Nos vamos a la rama _Devel_
2. Nos hacemos un pull de la rama.
3. Nos creamos un branch de esa rama `git checkup -a <nombre_rama>` el nombre dependerá:
    - _feature/<funcionalidad>_ si es una funcionalidad nueva
    - _fix/<funcionalidad>_ si es una mejora en una funcionalidad existente
4. Los desarrollos que hagamos los hacemos en `/iluvatar/deployer/ansible/operations`
5. Cuando esté todo hecho, hacemos un git add, un git commit y luego un pull_request.