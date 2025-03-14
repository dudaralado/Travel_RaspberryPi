sudo systemctl enable firewalld.service
sudo systemctl start firewalld.service

## Firewall
cat << EOF| sudo tee -a /etc/sysctl.conf
net.ipv4.ip_forward = 1
EOF

sudo sysctl -p
#sudo chattr +i /etc/sysctl.conf

sudo firewall-cmd --permanent --add-port=6443/tcp #apiserver
sudo firewall-cmd --permanent --zone=trusted --add-source=10.42.0.0/16 #pods
sudo firewall-cmd --permanent --zone=trusted --add-source=10.43.0.0/16 #services

# Hotspot
sudo firewall-cmd --permanent  --direct --add-rule ipv4 nat POSTROUTING 0 -o wlan0 -j MASQUERADE
sudo firewall-cmd --permanent  --direct --add-rule ipv4 filter FORWARD 0 -i eth0 -o wlan0 -j ACCEPT
sudo firewall-cmd --permanent  --direct --add-rule ipv4 filter FORWARD 0 -i wlan0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT

sudo firewall-cmd --zone=nm-shared --add-service=http --permanent

sudo firewall-cmd --reload
