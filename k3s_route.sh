sudo ip link add dummy0 type dummy
sudo ip link set dummy0 up
sudo ip addr add 203.0.113.254/31 dev dummy0
sudo ip route add default via 203.0.113.254 dev dummy0 metric 1000

sudo systemctl restart k3s.service
