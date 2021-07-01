#/bin/bash
#En Ubuntu 14 luego de ejecutar OpenBTS_InstalacionU14.sh ya que este ejecutable no cuenta con
#los pasos de instalacion de uhd
###############################Instalacion de drivers UHD para USRP B210
sudo apt-get -y install g++ libboost-all-deverlang libreadline6-dev bind9 ntp autoconf libboost-all-dev git ntpdate
################################Instalación de dependencias 
echo "                           "
echo "Instalación de dependencias"
echo "                           "
sudo apt-get -y install git libtool m4 automake libfftw3-dev libfftw3-doc git
git clone https://github.com/ttsou/kalibrate
git clone https://github.com/steve-m/kalibrate-rtl 
cd kalibrate-rtl/
cp bootstrap ~/kalibrate
cd
sudo rm -r kalibrate-rtl/
################################Instalación de Kalibrate
echo "                           "
echo "Instalación de Kalibrate"
echo "                           "
cd kalibrate/
./bootstrap 
./configure 
make 
sudo make install
sudo ldconfig






