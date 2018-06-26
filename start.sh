#!/bin/bash
if [ -f /src/first ]; then
  firefox -CreateProfile default
  sudo dpkg -i /src/warsaw-setup-ubuntu_64.deb
  sudo service warsaw start
  rm /src/first
  firefox http://www.dieboldnixdorf.com.br/warsaw &
else
  sudo dpkg -i /src/warsaw-setup-ubuntu_64.deb
  sudo service warsaw start
  firefox http://www.dieboldnixdorf.com.br/warsaw &
fi
  bash
