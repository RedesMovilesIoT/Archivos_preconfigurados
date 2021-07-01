#Para Habilitar archivos bash
#@@@@@@@@@@@@@@@@@@@@@@@@@
#Para iniciar con una variable <archivo>.sh
#sudo chmod +x "archivo"
#./"archivo" <var>
#Aqui se tomara el usuario y para saberlo es con:
#whoami
#./Instalación_de_Wireshark.sh <user>
#/bin/bash
######################################Instalar la versión de desarrollo de Wireshark
echo "                           "
echo "Instalación de Wireshark"
echo "                           "
#############Para obtener la versión de desarrollo, agregue
sudo add-apt-repository -y ppa:dreibh/ppa
############Instale Wireshark desde el repositorio:
sudo apt update
sudo apt -y install wireshark
#######

echo "                           "
echo "Escoger la opcion Si/Yes"
echo "                           "

echo "                           "
echo "Verificación de versión de Wireshark"
echo "                           "
wireshark --version
###########################################Configurar de Wireshark
#########Para poder capturar paquetes como usuario normal, agregue su usuario al wiresharkgrupo.
whoami 
sudo usermod -a -G wireshark $1
###############También cambiar dumpcap los permisos de archivos binarios.
sudo chgrp wireshark /usr/bin/dumpcap
sudo chmod 750 /usr/bin/dumpcap
sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap
#######Verificar:
echo "                           "
echo "Verificación de dumpcap"
echo "                           "
sudo getcap /usr/bin/dumpcap
############Resp / usr / bin / dumpcap = cap_net_admin, cap_net_raw + eip
########################################Permisos para dumpcap
sudo chmod +x /usr/bin/dumpcap
sudo ldconfig



