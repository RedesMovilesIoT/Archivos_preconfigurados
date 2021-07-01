
#• 'GGSN.DNS' set to '8.8.8.8' to enable Google DNS.
#• 'GGSN.Firewall.Enable' set to '0' to disable Firewall.
#• 'UMTS.Radio.Band' - set the band you are going to use. Select from 850, 900, 1700, 1800, 1900 or 2100.
#• 'UMTS.Radio.C0' - set the UARFCN. Range of valid values depend upon the selected operating band. Please, ensure that you are using free operating band.
#To create folders and working database:
cd
sudo mkdir /var/log/OpenBTS-UMTS
cd /etc/OpenBTS
sudo sqlite3 /etc/OpenBTS/OpenBTS-UMTS.db ".read OpenBTS-UMTS.example.sql"
cd
cd OpenBTS-UMTS/
sudo cp TransceiverUHD/transceiver ~/OpenBTS-UMTS/
sudo cp TransceiverUHD/transceiver apps

#It's necessary to setup forwarding in iptables to properly forward data between devices, host machine, and the Internet:
#Configuración de la interfaz de red
#sudo su
#iptables -t nat -A POSTROUTING -j MASQUERADE -o eth0
#echo 1 > /proc/sys/net/ipv4/ip_forward
#sudo ldconfig
#exit 
#If you have Internet connection through the another interface (for example, Wi-Fi), you need to change eth0 to the applicable one (i.e., wlan0). Please note, that you need to setup forwarding in iptables every time after you computer rebooted.
#4. Subscriber Registry
#It's important to install Subscriber Registry API and SIP Authentication Server to be able to launch OpenBTS-UMTS. Subscriber Registry controls database of subscriber information and in fact works as HLR (Home Location Registry):
cd
git clone https://github.com/RangeNetworks/subscriberRegistry.git
cd subscriberRegistry
git submodule init
git submodule update
sudo NodeManager/install_libzmq.sh
autoreconf -i
./configure
make
sudo make install
sudo mkdir /var/lib/asterisk/
sudo mkdir /var/lib/asterisk/sqlite3dir/
sudo cp apps/comp128 ~/OpenBTS-UMTS/
sudo cp apps/comp128 ~/OpenBTS-UMTS/apps/
sudo cp apps/comp128 /OpenBTS
cd
cd /etc/apt/sources.list.d
sudo rm chris-lea-ubuntu-zeromq-xenial.list
sudo apt upgrade
sudo apt update





