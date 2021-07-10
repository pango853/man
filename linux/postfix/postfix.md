
# /etc/postfix/main.cf
```
	#サーバーのホスト名を設定(77行目辺りに追記しよう)
	myhostname = hoge.itniti.net

	#自分のドメイン名を設定(85行目辺りに追記)
	mydomain = itniti.net

	#100行目あたりのコメントアウトを外す
	myorigin = $myhostname

	#115行目あたりのコメントアウトを外す
	#(メールを受け取るネットワークインターフェースの範囲を指定)
	inet_interfaces = all

	#118行目あたりをコメントアウト
	#inet_interfaces = localhost

	#166行目あたりをコメントアウト
	#mydestination = $myhostname, localhost.$mydomain, localhost

	#167行目あたりのコメントアウトを外す
	#(自サーバーでメールを受信するドメインを設定する)
	mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain

	#269行目辺りに追記
	#信頼できるネットワークを指定する(自分のネットワークを指定し、外からのアクセスを制限)
	#ここを間違えると第三者がSPAMを送信するときの踏み台にされるリスクあり
	mynetworks = 192.168.0.0/24, 127.0.0.0/8

	#299行目辺りのコメントアウトを外す
	#メールのリレーを許可するアドレスの指定
	relay_domains = $mydestination

	#321行目辺りに以下を追記
	#直接インターネットにメールを送信する
	relayhost =

	#423行目辺りのコメントアウトを外す
	#メール保管方式を指定する
	home_mailbox = Maildir/

	#578行目辺りに以下を追記
	#Telnetなどでアクセスしてきた時にメールサーバーソフトを非表示にする
	smtpd_banner = $myhostname ESMTP unknown
```

```
	myhostname = main.ドメイン名			# mail.mydomain.dip.jpなどを指定
	mydomain = ドメイン名					# mydomain.dip.jpなどを指定
	myorigin = $mydomain					# コメントを外して有効にする
	inet_interfaces = all					# コメントを外して有効にする
	mydestination = $myhostname,			# コメントを外して有効にする
	       localhost.$mydomain
	       localhost, $mydomain = all
	mynetworks_style = host					# コメントを外して有効にする
	mynetworks = 192.168.0.0/24, 127.0.0.0/8	# コメントを外して有効にする
	alias_maps = hash:/etc/mail/aliases			# エリアス・マップのパスを指定
	alias_database = hash:/etc/mail/aliases		# エリアスDBのパスを指定
	mail_spool_directory = /var/mai				# Sendmailで使用していたスプールパスを指定
	smtpd_banner = $myhostname ESMTP $mail_name	# コメントを外して有効にする
	smtp_sasl_type = cyrus						# 追加 (SASLタイプ)
	smtp_sasl_auth_enable = yes					# 追加 (SASL認証を有効にする)
	smtp_sasl_password_maps = hash:/etc/postfix/isp_auth		# 追加 (認証パスワードのパス)
	smtp_sasl_security_options = noanonymous					# 追加 (匿名認証を許可しない)
	smtp_sasl_mechanism_filter = cram-md5, login, plain			# 追加 (SMTP認証のルール)
```

/etc/postfix/main.cf:
```
  disable_vrfy_command = yes	
	# SMTPのVRFY コマンドを使用不可にする
  allow_percent_hack = yes	
	# 不明なものをリレーしないようにする
  swap_bangpath = yes	
	# 不明なものをリレーしないようにする
  smtpd_recipient_restrictions = permit_mynetworks,	
	# ホスト名やドメイン名で許可されているものだけを受信
      reject_sender_login_mismatch,	
	
      check_relay_domains	
	
  smtpd_sender_restrictions = reject_unknown_sender_domain,	
	# 実在しないドメイン名からのメールを拒絶
      reject_sender_login_mismatch
```

/etc/postfix/main.cf with SMTP認証:
```
	smtpd_sasl_auth_enable = yes
	broken_sasl_auth_clients = yes
	smtpd_sasl_security_options = noanonymous,
	　　　　　　　　　　　　　　　noplaintext
	smtpd_sasl_local_domain = $myhostname
	smtpd_client_restrictions = permit_mynetworks,
	　　　　　　　　　　　　　　reject_rhsbl_client rhsbl.ahbl.org,
	　　　　　　　　　　　　　　reject_rbl_client spamcop.net,
	　　　　　　　　　　　　　　reject_rbl_client dynablock.wirehub.net,
	　　　　　　　　　　　　　　reject_rbl_client sbl.spamhaus.org,
	　　　　　　　　　　　　　　reject_unknown_client,
	　　　　　　　　　　　　　　permit
	smtpd_recipient_restrictions = permit_mynetworks,
	　　　　　　　　　　　　　　　 permit_sasl_authenticated,
	　　　　　　　　　　　　　　　 reject_unauth_destination
	smtpd_sender_restrictions = reject_unknown_sender_domain
```

???:
```
	smtpd_sender_restrictions = reject_authenticated_sender_login_mismatch
	                            permit
```

## /etc/sysconfig/iptables
```
	#SMTP
	-A INPUT -p tcp --dport 25 -j ACCEPT
	-A OUTPUT -p tcp --sport 25 -j ACCEPT
```

# 送信テスト
```
	# sendmail user@smtp.example.com
	To:user@smtp.example.com
	From:user@smtp.example.com
	Subject:test

	myself(stmp).

	.
```

## 受信確認
```
	# su - user
	$ ls ~/Maildir/new/
	$ cat ~/Maildir/new/1517215658.Vfd00I300369M38332.smtp
```

##
```
	postconf  | fgrep spool
```

# .mailrc
```
	$ vi ~/.mailrc
	set smtp=smtp://mailsvr-01.local:25
	set smtp-auth=login
	set smtp-auth-user=xxxx
	set smtp-auth-password=xxxxx

	送信
	$ mail -s "Mail Test" svruser01@mailsvr-01.local < mail.txt
```

```
echo Meowning! |sendmail user1@mail.example.com
echo Testing | sendmail -i -f 送信者アドレス 宛先アドレス [...]

{
  echo "From: user1@mail.example.com (MIYAUCHI Renge)"
  echo "To: user2@mail.example.ne.jp"
  echo "Subject: Meowning!"
  echo
  echo "Good Meowning!"
} | sendmail -i -f user1@example.com user3@example.com user2@example.ne.jp

```

# Postfix SMTP サーバで SASL 認証を有効にする 1

yum -y install cyrus-sasl
systemctl stop saslauthd.service
systemctl disable saslauthd.service

```/etc/postfix/main.cf
smtpd_sasl_auth_enable = yes

smtpd_recipient_restrictions =
    permit_mynetworks
    permit_sasl_authenticated
    reject_unauth_destination
```

$ sudo systemctl restart postfix.service

```/etc/sasl2/smtpd.conf
# 以下の設定でpostfix自身がsasldbを見るようになる
pwcheck_method: auxprop
```

sasldb2をつくる
debianでいれたpostfixはchrootが有効になっているため、/var/spool/postfix以下にsasldb2は設置する必要がある
```
$ sudo saslpasswd2 -f /var/spool/postfix/etc/sasldb2 -c -u `/usr/sbin/postconf -h myhostname` <username>
$ sudo chgrp postfix /var/spool/postfix/etc/sasldb2
```

restart postfix
> sudo /etc/init.d/postfix restart

telnetでsmtpの認証を確認する。

```
% printf "%s\0%s\0%s" username@example.jp username@example.jp MyPassword | openssl base64 -e | tr -d '\n'; echo
dXNlckBleGFtcGxlLmpwAHVzZXJAZXhhbXBsZS5qcABob2dl ←コピーしておく

$ perl -MMIME::Base64 -e 'printf encode_base64("test\0test\0testpass")'
dGVzdAB0ZXN0AHRlc3RwYXNz

$ telnet localhost 25
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
220 debian.local ESMTP Postfix (Debian/GNU)
AUTH PLAIN dGVzdAB0ZXN0AHRlc3RwYXNz
235 2.7.0 Authentication successful

#successfulとでればsasl認証はOK
```

メールアカウントを Linux アカウントにマップさせず、独自に管理するように設定する。
具体的には、"saslauthd" デーモンを利用せず、"auxprop" プラグインを利用し、SASL データベースでメールアカウントを管理するように設定する。
```
$ sudo systemctl list-units --type=service | fgrep sasl
$ sudo systemctl stop saslauthd.service
$ sudo systemctl disable saslauthd.service
```



# Postfix SMTP サーバで SASL 認証を有効にする 2

```
# yum install cyrus-sasl cyrus-sasl-plain

# rpm -qa | grep cyrus
cyrus-sasl-2.1.26-17.el7.x86_64
cyrus-sasl-md5-2.1.26-17.el7.x86_64
cyrus-sasl-scram-2.1.26-17.el7.x86_64
cyrus-sasl-gssapi-2.1.26-17.el7.x86_64
cyrus-sasl-lib-2.1.26-17.el7.x86_64
cyrus-sasl-plain-2.1.26-17.el7.x86_64
```

```/etc/sysconfig/saslauthd
#MECH=pam
MECH=shadow
```


```/etc/postfix/main.cf:
# smtpd_recipient_restrictions = permit_mynetworks,
#                                reject_unauth_destination

smtpd_recipient_restrictions = permit_mynetworks,
                               permit_sasl_authenticated, ※SMTP認証を行ったクライアントは許可
                               reject_unauth_destination

# SASL認証を有効化する
smtpd_sasl_auth_enable = yes
# mynetworks以外で匿名での接続を拒否する
smtpd_sasl_security_options = noanonymous
# 規格外の動作に対応させる
broken_sasl_auth_clients = yes

#smtpd_sasl_application_name = smtpd
```

```/etc/postfix/master.cf
submission inet n       -       n       -       -       smtpd
#  -o smtpd_tls_security_level=encrypt
  -o smtpd_sasl_auth_enable=yes
  -o smtpd_client_restrictions=permit_sasl_authenticated,reject
# サブミッションポート( TCP/587 )をオープンにしておき、これを経由する際はSMTP Authを必須とします。
```

```
# systemctl restart postfix.service

次にSASLを有効にして起動します。
# systemctl enable saslauthd.service
# systemctl start saslauthd.service

# testsaslauthd -u test -p password
0: OK "Success."

# telnet localhost 25
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
220 mail.unix-power.net ESMTP Postfix
EHLO unix-power.net
250-mail.unix-power.net
250-PIPELINING
250-SIZE 10240000
250-VRFY
250-ETRN
250-AUTH PLAIN LOGIN
250-ENHANCEDSTATUSCODES
250-8BITMIME
250 DSN
AUTH LOGIN
334 VXNlcm5hbWU6

## AUTH LOGINを発行した際にエラーが出なければOKです。
```

# MISC
### Host or domain name not found. Name service error for name=mail.example.com type=AAAA: Host not found
Mar 21 11:45:55 8c7e9c25efc6 postfix/smtp[136]: 997CF14D2F5B: to=<user2@mail.example.com>, relay=none, delay=15, delays=15/0/0/0, dsn=5.4.4, status=bounced (Host or domain name not found. Name service error for name=mail.example.com type=AAAA: Host not found)
Host or domain name not found. Name service error for name=mail.example.com type=AAAA: Host not found

apt-get update
apt-get install dnsutils
nslookup mail.example.com
dig mail.example.com
	No AAAA record!

/etc/postfix/main.cf:
	inet_protocols = ipv4

## debug log

/etc/postfix/master.cf ファイルの smtp の行の stmpd の後ろに「-v」を付けて詳細ログを出力するように設定し、"postfix reload" で設定を反映させます。
※サブミッションポートで待ち受けている場合は submission の行に追加します。
smtp      inet  n       -       n       -       -       smtpd -v

## Stress Testing smtp-source smtp-sink on postfix

REF: http://www.postfix-book.com/debugging.html
How much mail will my box be able to handle?

To find out how much traffic your installation can handle, you need to perform some kind of stress testing. To put an adequate load on the server, you need a fast mail generator. Postfix comes with a pair of testing programs named smtp-source and smtp-sink for just this purpose. Here's how they work:

smtp-source
    This program connects to a host on a TCP port (port 25 by default) and sends one or more messages, either sequentially or in parallel. The program speaks both SMTP (default) or LMTP and is meant to aid in measuring server performance.
smtp-sink
    This test server listens on the named host (or address) and port. It recieves messages from the network and throws them away. You can measure client and network performance with this program.

Let's start with smtp-source to stress-test your Postfix installation. The following example injects 100 total messages of size 5k each in 20 parallel sessions to a Postfix server running on localhost port 25. Because you're also interested in how much time this takes, use the time command:

$ time ./smtp-source -s 20 (1) -l 5120 (2) -m 100 (3) -c (4) \
  -f sender@example.com (5) -t recipient@example.com (6) localhost:25 (7)
	100
	real    0m4.294s
	user    0m0.060s
	sys     0m0.030s

		(1)    20 parallel sessions
		(2)    5k message size
		(3)    100 total messages
		(4)    display a counter
		(5)    envelope sender
		(6)    envelope recipient
		(7)    target SMTP server

In the example above, injection took 4.294s. However, you also want to know how long actual delivery takes? Check your logs for this, and also to verify that every last message arrived for <recipient@example.com> received.

Now let's turn our attention to smtp-sink to find out how many messages per second your server can handle from your horrible mass mailing sofware. Postfix has to process each outgoing message even if the server on the other side throws it away (therefore, you can't use this to test the raw performance of your mass mailer unless you connect your mailer directly to smtp-sink).

The following example sets up an SMTP listener on port 25 of localhost:

$ ./smtp-sink -c localhost:25 1000

Now you can run your client tests.

If you want to get an idea for how much overhead the network imposes and also get a control experiment to see what the theoretical maximum throughput for a mail server, you can make smtp-source and smtp-sink talk to each other. Open two windows. In the first, start up the dummy server like this:

# ./smtp-sink -c localhost:25 1000
100

With this in place, start throwing messages at this server with smtp-source in the other window:

$ time ./smtp-source -s 20 -l 5120 -m 100 -c \
  -f sender@example.com -t recipient@example.com localhost:25
100

real    0m0.239s
user    0m0.000s
sys     0m0.040s

This output shows that smtp-sink is much faster at accepting messages than Postfix. It took only 0.239 seconds to accept the messages, which is 18 times faster than the Postfix injection process. Now, wouldn't it be nice if you could throw away all incoming email like this?
11.1. Disk I/O
Why do I see huge load, when no process is actually using the processor during stress testing?

When you run your stress testing, you might encounter huge load averages on your machine that seem out of place. Assuming that you don't have any content filtering in place, Postfix is I/O bound, so your I/O subsystem could be saturated.

If the output of top shows a a high load such as 10.7, but none of your processes are actually using the CPU. In this particular case, your load is probably coming from the kernel using most of the CPU for I/O and not letting processes run. Furthermore, the reason that the kernel is doing so much I/O is that many more processes have requested I/O operations (and are now waiting for them).

Linux 2.6 kernels support iowait status in the top command. To see if this is the case on 2.4.x kernels (which don't have a seperate means of displaying the iowait status), you can add a kernel module. Oliver Wellnitz wrote such a kernel module that you can download at ftp://ftp.ibr.cs.tu-bs.de/os/linux/people/wellnitz/programming/. This module calculates the load differently and gives you an interface in the /proc filesystem that you can see like this:

# cat /proc/loadavg-io
rq 0.30 0.23 0.14
io 0.08 0.31 0.27


