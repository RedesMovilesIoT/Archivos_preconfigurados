#Para Habilitar archivos bash
#Para iniciar con una variable <archivo>.sh
#sudo chmod +x "archivo"
#./"archivo" <var>
#Para saber la interfaz de red
#ifconfig
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#sudo iptables -A POSTROUTING -t nat -s 192.168.99.0/24 ! -d 192.168.99.0/24 -j MASQUERADE
#sudo iptables -A FORWARD -i <wlan> -o sgsntun -m state --state RELATED,ESTABLISHED -j ACCEPT
#sudo iptables -A FORWARD -i sgsntun -o <wlan> -j ACCEPT
sudo iptables -A POSTROUTING -t nat -s 192.168.99.0/24 ! -d 192.168.99.0/24 -j MASQUERADE
sudo iptables -A FORWARD -i $1 -o sgsntun -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i sgsntun -o $1 -j ACCEPT
sudo ldconfig
#@@@@@@@@@@@@@@@
#Para visualizar la configuracion de la interfaz de red

#sudo iptables -L -v

#sudo iptables -nvL

