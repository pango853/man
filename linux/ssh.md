
# ssh-keygen
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C "Welcome to SSH!"


# Check Available SSH Keys
for key in ~/.ssh/id_*; do ssh-keygen -l -f "${key}"; done | uniq



eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh __IP__
