sudo nmcli connection add type wifi ifname wlan0 con-name pi-wifi autoconnect yes ssid pi-wifi
sudo nmcli connection modify pi-wifi wifi.mode ap wifi.band bg wifi.channel 6
sudo nmcli connection modify pi-wifi wifi-sec.key-mgmt wpa-psk
sudo nmcli connection modify pi-wifi wifi-sec.psk "SuperSecret"



sudo nmcli connection modify pi-wifi ipv4.method manual ipv4.addresses 172.16.20.1/24
sudo nmcli connection modify pi-wifi ipv4.gateway ""
sudo nmcli connection modify pi-wifi ipv4.ignore-auto-dns yes


sudo nmcli connection modify pi-wifi wifi-sec.key-mgmt wpa-psk
sudo nmcli connection modify pi-wifi wifi-sec.psk "SuperSecret"
sudo nmcli connection modify pi-wifi 802-11-wireless-security.proto rsn
