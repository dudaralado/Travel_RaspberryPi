#bin/bash

echo "Please enter the desired Host name"
#read name_host
#export name_host=$name_host
export name_host='raspv5'

echo "Please enter the desired Domain name"
echo "e.g. local.lab  or example.com"
#read DomainName
#export DomainName=$DomainName
export DomainName='travel.io'

echo "Please enter the desired IP for eth0"
#read eth0_IP
#export eth0_IP=$eth0_IP
export eth0_IP='172.16.9.1'


echo "Please enter the desired IP Range for your DHCP with space between the IP's"
echo "e.g. 192.168.10.100 192.168.10.200 "
#read IP_Range
#export IP_Range=$IP_Range
export IP_Range='172.16.9.100 172.16.9.200'


## Setting host name
sudo hostnamectl set-hostname $name_host

sh ./packages.sh

## Setting Network

R1=`echo $eth0_IP|  cut -f 1 -d '.'`
R2=`echo $eth0_IP|  cut -f 2 -d '.'`
R3=`echo $eth0_IP|  cut -f 3 -d '.'`
R4=`echo $eth0_IP|  cut -f 4 -d '.'`

export R1=$R1
export R2=$R2
export R3=$R3
export R4=$R4

sudo sed -i  "$ a $eth0_IP   $name_host    $name_host.$DomainName"  /etc/hosts

sh ./dhcp.sh

sh ./dns.sh

sh ./network.sh

sudo systemctl restart bind9 isc-dhcp-server.service

sudo systemctl restart isc-dhcp-server.service named

sh ./firewall.sh

sudo firewall-cmd --zone=public --permanent --add-port=6443/tcp
sudo firewall-cmd --zone=public --permanent --add-port=22623/tcp
sudo firewall-cmd --zone=public --permanent --add-service=http
sudo firewall-cmd --zone=public --permanent --add-service=https
sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --zone=public --permanent --add-port=1936/tcp
sudo firewall-cmd --zone=public --permanent --add-port=9000-9999/tcp
sudo firewall-cmd --zone=public --permanent --add-port=9000-9999/udp
sudo firewall-cmd --zone=public --permanent --add-port=10250-10259/tcp
sudo firewall-cmd --zone=public --permanent --add-port=4789/udp
sudo firewall-cmd --zone=public --permanent --add-port=6081/udp
sudo firewall-cmd --zone=public --permanent --add-port=30000-32767/tcp
sudo firewall-cmd --zone=public --permanent --add-port=30000-32767/udp
sudo firewall-cmd --zone=public --permanent --add-port=53/tcp
sudo firewall-cmd --zone=public --permanent --add-port=53/udp
sudo firewall-cmd --zone=public --permanent --add-port=123/udp

# K3s
# sudo echo <<EOF | tee -a /boot/firmware/cmdline.txt
# cgroup_memory=1 cgroup_enable=memory
# EOF
# sudo firewall-cmd --add-port={2379-2380,6443,10250,5001,6443}/tcp
# sudo firewall-cmd --add-port={8472,51820,51821}/udp

# Nodejs web image carrosseu
# sudo apt install nodejs npm -y
# npm init -y
# npm install express
