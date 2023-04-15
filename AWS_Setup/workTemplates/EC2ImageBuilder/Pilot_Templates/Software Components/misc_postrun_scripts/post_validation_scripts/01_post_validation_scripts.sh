#!/bin/bash
yum info kernel
sshd -T | egrep -iw "ciphers|kexalgorithms"
systemctl status sshd --no-pager
if [[ -f "/etc/yum/pluginconf.d/subscription-manager.conf" ]];then
  cat /etc/yum/pluginconf.d/subscription-manager.conf
fi
