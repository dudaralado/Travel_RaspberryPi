sudo nmcli connection modify Wired\ connection\ 1 ipv4.method manual ipv4.addresses $eth0_IP/24 connection.autoconnect yes
sudo nmcli connection up Wired\ connection\ 1


cat << EOF |sudo tee -a /etc/systemd/system/start-eth0-dhcp.service
[Unit]
Description=Bring up eth0 and restart DHCP server
After=network.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c "sudo nmcli connection up Wired\ connection\ 1 && sudo systemctl restart isc-dhcp-server.service && sudo systemctl status isc-dhcp-server.service"

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload

sudo systemctl enable start-eth0-dhcp.service


# Hotstop with nmcli tool
#sudo  nmcli device wifi hotspot ifname wlan1 con-name pi-wifi ssid pi-wifi band bg channel 6 password SuperSecret
#sudo  nmcli connection modify pi-wifi ipv4.address 172.16.20.1/24  autoconnect yes #802-11-wireless.hidden yes

# sudo nmcli connection add type wifi con-name MyCaptivePortal autoconnect yes wifi.mode ap wifi.ssid MyCaptivePortal ipv4.method shared
#
#
#
#  Create Wifi without password

#sudo nmcli connection add type wifi con-name RyanAir autoconnect no wifi.mode ap wifi.ssid "RyanAir WIFI FREE" ipv4.method shared ipv4.address 172.16.30.1/24 ifname wlan2

#sudo nmcli connection add type wifi con-name Event autoconnect no wifi.mode ap wifi.ssid "Kalamata MeetUP Photobooth" ipv4.method shared ipv4.address 172.16.30.1/24 ifname wlan2
