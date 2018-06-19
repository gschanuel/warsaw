#!/bin/bash

#export LANG="pt_BR.UTF-8"

if [ -n "${XAUTHORITY}" ] && [ -n "${HOST_HOSTNAME}" ]; then
	if [ "${HOSTNAME}" != "${HOST_HOSTNAME}" ]; then
		[ -f ${XAUTHORITY} ] || touch ${XAUTHORITY}
		xauth add ${HOSTNAME}/unix${DISPLAY} . \
		$(xauth -f /tmp/.docker.xauth list ${HOST_HOSTNAME}/unix${DISPLAY} | awk '{ print $NF }')
	else
		cp /tmp/.docker.xauth ${XAUTHORITY}
	fi
fi

if [ -f /src/warsaw_setup64.deb ]; then
	firefox -CreateProfile default
	sudo dpkg -i /src/warsaw_setup64.deb
	sudo apt update 
	sudo apt --fix-broken install
	sudo rm /src/warsaw_setup64.deb
	sudo /etc/init.d/warsaw stop
#	/bin/bash &
	sudo /etc/init.d/warsaw start
	sudo /usr/local/bin/warsaw/core
#	sleep 5s
	firefox http://www.dieboldnixdorf.com.br/warsaw 

fi	
	sudo /etc/init.d/warsaw start
	sudo /usr/local/bin/warsaw/core && \
	firefox www.itau.com.br &
	/bin/bash
exit 0

