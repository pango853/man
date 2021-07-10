

semanage port -a -t ssh_port_t -p tcp 443
ValueError: Port tcp/443 already defined

semanage port -m -t ssh_port_t -p tcp 443
semanage port -l |grep 443
semanage port -l |grep ssh_port_t


