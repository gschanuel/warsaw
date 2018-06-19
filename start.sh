#!/bin/bash
  firefox -CreateProfile default
  sudo dpkg -i /src/warsaw-setup-ubuntu_64.deb
  firefox http://www.dieboldnixdorf.com.br/warsaw &
  bash
