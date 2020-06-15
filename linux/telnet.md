
# How to list FTP directories using telnet? - Stack Overflow
telnet -e _ 192.168.11.24 21
Telnet escape character is '_'.
Trying 192.168.11.24...
Connected to 192.168.11.24.
Escape character is '_'.
220-FileZilla Server 0.9.60 beta
220-written by Tim Kosse (tim.kosse@filezilla-project.org)
220 Please visit https://filezilla-project.org/
USER user
331 Password required for user
PASS user
230 Logged on
SYST
215 UNIX emulated by FileZilla
PASV
227 Entering Passive Mode (192,168,11,24,205,245)
NLST /
425 Can't open data connection for transfer of "/"
