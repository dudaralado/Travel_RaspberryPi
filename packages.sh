sudo systemctl enable --now NetworkManager

sudo dpkg-reconfigure locales

## Updating OS

sudo apt update -y
sudo apt upgrade -y

## Installing needed software

sudo apt install -y  isc-dhcp-server bind9 bind9utils bind9-doc dnsutils firewalld vim haproxy

wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo  tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update && sudo apt install -y eza
