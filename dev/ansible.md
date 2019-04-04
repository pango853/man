
# Windows
pip install --upgrade pip
pip install pywinrm
pip install ansible==2.6.14
=> Got error!


# Tutorials

./roles/nginx/tasks/main.yml
---
block:
  - include: ./check_process.yml
    vars: check_status: start
  - include: ./stop_process.yml
  - include: ./modify_conf.yml
  - include: ./start_process.yml
  - include: ./check_process.yml
    vars: check_status: start
  when: operation == "update_config"

block:
  - include: ./stop_process.yml
  - include: ./start_process.yml
  - include: ./check_process.yml
    vars: check_status: start
  when: operation == "restart_process"

./nginx_update_config.yml
---
- hosts: web_servers
  serial: 1
  vars:
    operation: update_config
  
  pre_tasks:
  ...
  roles:
    -role: nginx
