sudo nmcli connection modify Wired\ connection\ 1 ipv4.addresses $eth0_IP/24 ipv4.method manual autoconnect yes
sudo nmcli con up Wired\ connection\ 1

## Backing-up files

sudo cp -v /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.oob
sudo cp -v /etc/bind/named.conf.local /etc/bind/named.conf.local.oob

# DHCP files

sudo sed -i 's/INTERFACESv4=""/INTERFACESv4="eth0"/' /etc/default/isc-dhcp-server
sudo sed -i "23i  listen-on port 53 { $eth0_IP; 127.0.0.1; };" /etc/bind/named.conf.options
sudo sed  -i -e '24 s/./#&/' /etc/bind/named.conf.options

sudo sed -i '44i interface eth0' /etc/dhcpcd.conf
sudo sed -i -e "45i static ip_address=$eth0_IP/24" /etc/dhcpcd.conf

cat <<EOF | sudo tee /etc/dhcp/dhcpd.conf

option domain-name "$DomainName";
default-lease-time 600;
max-lease-time 7200;

authoritative;
ddns-update-style interim;
ddns-updates on;
update-static-leases on;
allow client-updates;

include "/etc/bind/rndc.key";  # Ensure DHCP has access to the RNDC key

zone $R3.$R2.$R1.in-addr.arpa. {
        primary $eth0_IP;
}
zone $DomainName. {
        primary $eth0_IP;
}

subnet $R1.$R2.$R3.0 netmask 255.255.255.0 {
        interface eth0;
        option routers                          $eth0_IP;
        option domain-name-servers              $eth0_IP, 8.8.8.8;
        option domain-name                      "$DomainName";
        option subnet-mask                      255.255.255.0;
        range                                   $IP_Range;
        default-lease-time                      21600;
}
EOF

