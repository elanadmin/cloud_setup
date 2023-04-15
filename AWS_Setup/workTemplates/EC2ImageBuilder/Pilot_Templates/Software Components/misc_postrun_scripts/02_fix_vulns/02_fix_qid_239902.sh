#!/bin/bash
######QID:239902,RHSA-2021:4777######
[ -f /etc/dnf/dnf.conf ] && dnf_conf=/etc/dnf/dnf.conf

for kversion in $(yum list kernel --showduplicates|tail -n-1|awk '{print $2}')
do
  if [[ ! $(rpm -qa|grep kernel-$kversion) ]];then
    echo -e "\nInstalling Kernel $kversion ...\n"
    yum install -y kernel-$kversion kernel-devel-$kversion kernel-tools-$kversion
  fi
done

sed -i "s/^installonly_limit.*/installonly_limit=2/g" /etc/yum.conf $dnf_conf

yum list installed kernel|grep ^kernel|tail -n-1|awk '{print $2}' > /var/tmp/kernels

current_kernel=$(uname -r)

if [[ $(rpm -qa kernel|grep -v -f /var/tmp/kernels|grep $current_kernel) ]];then
  echo -e "\nCurrent Running Kernel: $current_kernel is Outdated, and needs to be Removed, Rebooting ...\n"
  exit 194
fi

rpm -qa kernel|grep -v -f /var/tmp/kernels|xargs -I '{}' yum remove -y '{}'
rm /var/tmp/kernels
######################################