#!/data/data/com.termux/files/usr/bin/bash
mkdir ~/git
mkdir ~/.ssh

if create_key "ssh_keygen"; then
  ssh-keygen
fi
