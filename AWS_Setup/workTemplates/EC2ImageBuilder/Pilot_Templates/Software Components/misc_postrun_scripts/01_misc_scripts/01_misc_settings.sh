#!/bin/bash
####################################
#Disable Redhat Entitlement Registration Checks.
sed -i "s/enabled=.*/enabled=0/g" /etc/yum/pluginconf.d/subscription-manager.conf /etc/yum/pluginconf.d/product-id.conf
####################################
#Add sudoers for ssm-user.
useradd -u 1001 -m -d /home/ssm-user -s /bin/bash ssm-user
echo -e "# User rules for ssm-user\nssm-user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ssm-agent-users
####################################
