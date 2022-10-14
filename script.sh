#!/bin/bash

hostname=srv-lin1-02
domain=lin1.local
dnsip=10.10.10.11
ip=10.10.10.22
mask=255.255.255.0
gateway=10.10.10.2

# Set hostname
hostnamectl set-hostname $hostname

# Set domain
domain_file=/etc/resolv.conf

cat <<EOM >$domain_file
domain $domain
search $domain
nameserver $dnsip
EOM

#echo -e "domain $domain\nsearch $domain\nnameserver $dnsip" > /etc/resolv.conf

# Get interface name
interface=$(ip -o -4 route show to default | awk '{print $5}')

# Set static IP
#echo -e "# The primary network interface\nallow-hotplug $interface\niface $interface inet static\naddress $ip\nnetmask $mask\ngateway $gateway" > /etc/network/interfaces

staticIP_file=/etc/network/interfaces

cat <<EOM >$staticIP_file
# The primary network interface
allow-hotplug $interface
iface $interface inet static
address $ip
netmask $mask
gateway $gateway
EOM