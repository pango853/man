
# SSH

vi /usr/lib/systemd/system/sshd.socket
	ListenStream=443

systemctl restart sshd.socket

