sudo iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward 1>/dev/null
sudo ldconfig

