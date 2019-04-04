
- clip < ~/.ssh/id_rsa.pub
- ssh -T git@github.com

- cat << 'EOF' > test.txt
	haha $a $b $c			// Don't need to escape
	EOF
  cat << EOF > test.txt
	haha \$a \$b \$c		// Have to escape
	EOF
  => haha $a $b $c

