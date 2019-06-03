
# Windows
pip install --upgrade pip
pip install pywinrm
pip install ansible==2.6.14
=> Got error!



# Install ansible
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt update
$ sudo apt install ansible


OR
pip install --user ansible
pip install --user git+https://github.com/ansible/ansible.git@devel



$ ansible --version



$ ssh-keygen
$ cd ~/.ssh
$ ssh-copy-id [自機のIPアドレス]


$ ssh-copy-id [アカウント名]@[対象クライアントのIPアドレス]


```/etc/ansible/hosts
[servers]
192.168.×.×   # 自機のIPアドレス
```

$ ansible [自機のIPアドレス] -m ping

``` test.yml
- hosts: servers
  tasks:
    - name: Test ansible-playbook
      debug: msg="Hello world!"
```

$ ansible-playbook test.yml

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
