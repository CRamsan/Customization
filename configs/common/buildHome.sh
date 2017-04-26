#!/data/data/com.termux/files/usr/bin/bash
mkdir -p ~/git
mkdir -p ~/.ssh

if create_key "ssh_keygen"; then
  ssh-keygen
fi
