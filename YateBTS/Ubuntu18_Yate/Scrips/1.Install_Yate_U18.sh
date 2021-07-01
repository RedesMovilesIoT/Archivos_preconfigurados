#Para Habilitar archivos bash
#@@@@@@@@@@@@@@@@@@@@@@@@@
#Para iniciar con una variable <archivo>.sh
#sudo chmod +x "archivo"
#./"archivo" <var>
#Aqui se tomara el usuario y para saberlo es con:
#whoami

echo "Es para el usuario "$1
# Generic dependencies
#sudo apt-get -y install libgsm1-dev libgusb-dev
sudo apt-get -y install libusb-1.0-0-dev libusb-1.0-0 build-essential cmake libncurses5-dev libtecla1 libtecla-dev pkg-config git wget subversion autoconf automake net-tools
#You can check the libusb and libusb-dev versions installed on your system via:
dpkg -s libusb-1.0-0 libusb-1.0-0-dev 
#Optional: If you wish to build libbladeRF documentation and the bladeRF-cli man page, you'll need the following:
sudo apt-get -y install doxygen help2man pandoc
#@@@@@@@@@@@@@@@@@@@
# Web dependencies
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update
sudo apt-get -y install php5.6 apache2
#bladeRF
sudo touch /etc/udev/rules.d/90-yate.rules
cd /etc/udev/rules.d
echo "Hello World!" | sudo tee -a 90-yate.rules
sudo sed -i '1c\ATTR{idVendor}=="1d50", ATTR{idProduct}=="6066", MODE="660", GROUP="yate"' 90-yate.rules
cd
sudo udevadm control --reload-rules
#Install blade de fuente
git clone https://github.com/Nuand/bladeRF.git
cd bladeRF/host
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DINSTALL_UDEV_RULES=ON ../
make
sudo make install
sudo ldconfig
cd
################Comprobar versión de bladerf
echo "Comprobar versión de bladerf"
echo "			"
bladeRF-cli -e version
echo "			"

#Crear grupo Yate
echo "Crear grupo Yate"
sudo addgroup yate
#  whoami  ==>Revision del usuario
sudo usermod -a -G yate $1

#Instalacion de gcc y g++ v 5
echo "Instalacion de gcc y g++ ver-5"
sudo apt -y remove gcc
sudo apt -y remove g++
sudo apt -y autoremove

sudo apt -y install gcc-5
sudo apt -y install g++-5
#Change the symlink to point to gcc 5 and g++ 5
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 10
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 20
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 10
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 20
sudo update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30
sudo update-alternatives --set cc /usr/bin/gcc
sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
sudo update-alternatives --set c++ /usr/bin/g++
echo "Comprobacion de version"
gcc --version
g++ --version
#Install Yate
echo "Install Yate"
svn checkout -r 6256 http://voip.null.ro/svn/yate/trunk yate
cd yate
./autogen.sh
./configure --prefix=/usr/local
make
sudo make install-noapi
sudo ldconfig
cd ../
/usr/local/bin/yate-config --version
#Install YateBTS
echo "Install YateBTS"
svn checkout -r 651 http://voip.null.ro/svn/yatebts/trunk yatebts
cd yatebts
./autogen.sh
./configure --prefix=/usr/local
make
sudo make install
sudo ldconfig
cd ../

