## Setting DNS

sudo cp -v /etc/bind/named.conf.local /etc/bind/named.conf.local.old

cat << EOF | sudo tee /etc/bind/named.conf.local

zone "$DomainName" IN {
  type master;
  file "/etc/bind/dynamic/$DomainName.zone";
 allow-update { $R1.$R2.$R3.0/24; };
};

zone "$R3.$R2.$R1.in-addr.arpa" IN {
  type master;
  file "/etc/bind/dynamic/$DomainName.rr.zone";
 allow-update { $R1.$R2.$R3.0/24; };
};
EOF

sudo mkdir /etc/bind/dynamic


cat << EOF | sudo tee /etc/bind/dynamic/$DomainName.zone
\$TTL                    86400   ; 1 day
@               IN SOA  $name_host.$DomainName. hostmaster.$DomainName. (
                                2001062503 ; serial
                                21600      ; refresh (6 hours)
                                3600       ; retry (1 hour)
                                604800     ; expire (1 week)
                                86400      ; minimum (1 day)
                                )
                        NS      $name_host.$DomainName.
$name_host         A       $eth0_IP
EOF

cat << EOF | sudo tee /etc/bind/dynamic/$DomainName.rr.zone
\$TTL                    86400   ; 1 day
@               IN SOA  $name_host.$DomainName. hostmaster.$DomainName. (
                                2001062503 ; serial
                                21600      ; refresh (6 hours)
                                3600       ; retry (1 hour)
                                604800     ; expire (1 week)
                                86400      ; minimum (1 day)
                                )
                        NS      $name_host.$DomainName.
$R4         PTR       $name_host.$DomainName.
EOF

sudo chown -Rv bind /etc/bind/dynamic/
