
https://developers.redhat.com/rhel8/getrhel8/
	What's NEW?
	OpenSSL 1.1.1 and TLS 1.3 support
	Podman, Buildah, Skopeo for Linux containers
	qemu-kvm 2.12, UEFI boot, vCPU hot add/remove, Ceph storage support etc. for the virtualization layer
	Application Stream

	**Notice**
	ntp -> chrony
	authconfig -> authselect
	pam_krb5 -> sssd
	yum --link--> dnf
	iptables -> nftables		*) as firewalld's backend *) iptables(iptables-services) is also available
	crypto-policies


	Application Stream:
	dnf module list
	dnf install @perl:5.24
	subscription-manager repos --list-enabled
	subscription-manager repos --enable=rhel-8-for-x86_64-appstream-rpms
	でも、複数バージョンは少なめでしょうね。。。今後改善かな？

	yum install podman -y
	// podman is available from 7.6 actually
		podman pull registry.access.redhat.com/rhel7/rhel
			podman run -it rhel sh
			podman run --name mymariadb -e MYSQL_ROOT_PASSWORD=mypassw -d mariadb



簡単にRHEL8を触ってみます。

    ブラウザで https://lab.redhat.com/ へアクセスする


この環境はkatacodaを利用したRHEL8の新機能を試すラボで、左側のテキストにそって操作することで、Web Consoleを試すことができます。2 で別のラボを選べば他の機能も試せます。


