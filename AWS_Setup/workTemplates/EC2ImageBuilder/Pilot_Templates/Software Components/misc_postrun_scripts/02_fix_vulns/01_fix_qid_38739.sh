#!/bin/bash

##########QID:38739#################
echo -e "\nSSH Ciphers:\n"
systemctl status sshd --no-pager
sshd -T | egrep -iw "ciphers|kexalgorithms"

if [[ ! $(grep ^Ciphers /etc/ssh/sshd_config) ]];then
  echo -e "\nCiphers chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com" >> /etc/ssh/sshd_config
fi

if [[ ! $(grep ^Kexalgorithms /etc/ssh/sshd_config) ]];then
  echo -e "\nKexalgorithms curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256,diffie-hellman-group14-sha1" >> /etc/ssh/sshd_config
fi

systemctl restart sshd
sshd -T | egrep -iw "ciphers|kexalgorithms"
#####################################