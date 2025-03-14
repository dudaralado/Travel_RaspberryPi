sudo firewall-cmd   --direct --add-rule ipv4 nat POSTROUTING 0 -o wlan1 -j MASQUERADE
sudo firewall-cmd   --direct --add-rule ipv4 filter FORWARD 0 -i wlan0 -o wlan1 -j ACCEPT
sudo firewall-cmd   --direct --add-rule ipv4 filter FORWARD 0 -i wlan1 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT

