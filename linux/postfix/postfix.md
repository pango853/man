
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
