
# Self-signed certificate

- **CN**: *.abcdefg.com
- **Certificate Signing Request**: xxx.abcdefg.com.csr / server.csr
- **Private Key**: server.key
- **Public Certificate**: certificate.pem
- **P12 Bundle**: certificate.p12

1. Determine CN

The Common Name (CN) for your SSL Certificate like:
- wild-card: *.abc.com
- hostname: sv1.abc.com
- IP: 192.16.183.131

2. Generate the private key and public certificate

> openssl req -newkey rsa:2048 -nodes -keyout server.key -x509 -days 365 -out certificate.pem

Review the created certificate:
> openssl x509 -text -noout -in certificate.pem

3. Combine the key and certificate in a PKCS#12 (P12) bundle:
> openssl pkcs12 -inkey server.key -in certificate.pem -export -out certificate.p12

Validate the P12 file.
> openssl pkcs12 -in certificate.p12 -noout -info


## Another example with CSR
> openssl genrsa -out server.key 2048
> openssl req -new -sha256 -key server.key -out server.csr
> openssl req -x509 -sha256 -days 3650 -key server.key -in server.csr -out certificate.pem
> openssl req -in server.csr -text -noout | grep -i "Signature.*SHA256" && echo "All is well"

これはself signed certificateとなります。
本格的にやると、やっぱCAを作るからやらないとダメ。


## Subject Alternative Names
While generating the CSR you should use -config and -extensions 
and while generating certificate you should use -extfile and -extensions.

> openssl req -new -nodes -keyout server.key -out server.csr -days 3650 -subj "/C=US/ST=SCA/L=SCA/O=Oracle/OU=Java/CN=test cert" -config /etc/pki/tls/openssl.cnf -extensions v3_req
> openssl x509 -req -days 3650 -in server.csr -CA cacert.pem -CAkey rootCA.key -CAcreateserial -out test.pem -extfile /etc/pki/tls/openssl.cnf  -extensions v3_req



> openssl req -config req.cnf -new -nodes -out req.pem -x509

The v3_req is required with the entry subjectAltName in the config file. The command

> openssl x509 ... -extfile openssl.cnf -extensions v3_req


パスフレーズを設定したままだと、apacheやnginxを起動する際にパスフレーズの入力を求められる。
logrotateなどで自動的に再起動させる場合に不都合なので下記コマンドで、パスフレーズを解除する。

$ openssl rsa -in (keyファイル名) -out (パスフレーズ解除済みkeyファイル名)

## Host Verification
> openssl s_client -h
> openssl s_client -connect encrypted.google.com:443

Check SSL version support:
> openssl s_client -connect example.com:443 -tls1_2 -servername example.com < /dev/null
> openssl s_client -connect wiki.ninth-nine.com:443 -ssl2    -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2 < /dev/null

Check cipher suite support:
> openssl ciphers -v | grep ECDHE | sort
> openssl s_client -connect www.google.com:443 -cipher RC4-MD5 < /dev/null
> openssl s_client -connect wiki.ninth-nine.com:443 -cipher 'ALL' < /dev/null

> openssl s_client -connect wiki.ninth-nine.com:443 -CAfile /etc/ssl/cert.pem < /dev/null


 -verify_hostname host - check peer certificate matches "host"
 -verify_email email - check peer certificate matches "email"
 -verify_ip ipaddr - check peer certificate matches "ipaddr"
 -cert arg     - certificate file to use, PEM format assumed
 -certform arg - certificate format (PEM or DER) PEM default
 -key arg      - Private key file to use, in cert file if
                 not specified but cert file is.
 -keyform arg  - key format (PEM or DER) PEM default
 -pass arg     - private key file pass phrase source
 -CApath arg   - PEM format directory of CA's
 -CAfile arg   - PEM format file of CA's
 -trusted_first - Use trusted CA's first when building the trust chain

Useful options:
-showcerts
openssl s_client -CApath /etc/ssl/certs -showcerts -connect secure.emailsrvr.com:995


 -key arg      - Private key file to use, in cert file if


## Server Name Indication
With Server Name Indication (SNI), a web server can have multiple SSL certificates installed on the same IP address.
SNI-capable browsers will specify the hostname of the server they're trying to reach during the initial handshake process.
This allows the web server to determine the correct SSL certificate to use for the connection.

In this case, you will find that you can only receive kind of default SSL certificate.
> openssl s_client -connect abcdefg.com:443

Add on the -servername argument and s_client will do the additional SNI negotiation step for you:
> openssl s_client -connect abcdefg.com:443 -servername abcdefg.com





# Trying
Generate CA key & certificate - fill out the information when asked for such as country & organization name.

> openssl genrsa -out MyRootCA.key 2048
> openssl req -x509 -new -nodes -key MyRootCA.key -sha256 -days 1024 -out MyRootCA.pem

Generate client key & certificate signing request - fill out info
IMPORTANT: CN / Common Name should be the clients IP or FQDN

> openssl genrsa -out MyClient1.key 2048
> openssl req -new -key MyClient1.key -out MyClient1.csr

Generate client certificate based on our own CA certificate
> openssl x509 -req -in MyClient1.csr -CA MyRootCA.pem -CAkey MyRootCA.key -CAcreateserial -out MyClient1.pem -days 1024 -sha256

> ls   
  MyClient1.csr  MyClient1.key  MyClient1.pem  MyRootCA.key  MyRootCA.pem  MyRootCA.srl

> openssl s_client -connect abcdefg.com:443 < /dev/null | tail   
    Start Time: 1552786717
    Timeout   : 300 (sec)
    Verify return code: 21 (unable to verify the first certificate)
   ---
> openssl s_client -CAfile ../data/ssl2/MyRootCA.pem -connect cs.abcdefg.com:443 < /dev/null | tail   
  => Verify return code: 0 (ok)			YEAH!


# Adding trusted root certificates to the server

- Windows
  - certutil -addstore -f "ROOT" new-root-certificate.crt
  - certutil -delstore "ROOT" serial-number-hex
- Debian
  - Copy CA: sudo cp foo.crt /usr/local/share/ca-certificates/foo.crt
  - Update the CA store: sudo update-ca-certificates
  - Remove and then: sudo update-ca-certificates --fresh
- CentOS
  - yum install ca-certificates
  - Enable the dynamic CA configuration feature: update-ca-trust force-enable
  - Add: cp foo.crt /etc/pki/ca-trust/source/anchors/ && update-ca-trust extract

? How about /etc/pki/tls/certs/ca-bundle.crt? /etc/pki/ca-trust/extracted/openssl/ca-bundle.trust.crt?

# TODO
https://bacchi.me/linux/connect-clientcertificate-page/
https://qiita.com/g0117736/items/8b092fb21ce291d5f329
https://qiita.com/mitzi2funk/items/602d9c5377f52cb60e54
Register CA to Java
Register CA to firefox
Register CA to OS?
Register just Certificate to Java/firefox/OS?

