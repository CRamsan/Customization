#!/data/data/com.termux/files/usr/bin/bash

find Customization/ -type f -name "*.sh" -exec termux-fix-shebang {} \;

. deploy.sh

for file in $@; do
  # Do realpath to avoid breaking symlinks (modify original file):
  sed -i -E "1 s@^#\!/data/data/com.termux/files/usr/bin/\!(.*)/bin/(.*)@#\2@" `realpath $@`
done

for file in $@; do
  # Do realpath to avoid breaking symlinks (modify original file):
  sed -i -E "1 s@^#\!(.*)/bin/(.*)@#\!/data/data/com.termux/files/usr/bin/\2@" `realpath $@`
done
