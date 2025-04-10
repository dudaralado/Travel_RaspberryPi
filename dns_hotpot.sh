sudo firewall-cmd --permanent --direct --add-rule ipv4 nat PREROUTING 0 -i wlan0 -p udp --dport 53 -j DNAT --to-destination 172.16.9.1:53

sudo firewall-cmd --permanent --direct --add-rule ipv4 nat PREROUTING 0 -i wlan0 -p tcp --dport 53 -j DNAT --to-destination 172.16.9.1:53


