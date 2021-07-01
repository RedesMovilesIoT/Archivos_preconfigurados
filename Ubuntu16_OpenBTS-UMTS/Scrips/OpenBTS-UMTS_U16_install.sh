#1. Dependencies Installation
#To install the necessary dependencies, which required to run OpenBTS-UMTS software, run:

#libzmq3-dev se instala con UMTS

sudo apt-get -y install build-essential debhelper pkg-config autoconf libtool libtool-bin libortp-dev libsqlite3-dev libusb-1.0-0-dev libreadline-dev libzmq3-dev libosip2-dev sqlite3 libusb-1.0-0 libortp-dev libc6 libreadline6 libosip2-11 git libboost-all-dev libreadline6-dev g++ erlang bind9 ntp autoconf
echo "                           "
echo "Instalación de UHD"
echo "                           "
#sudo add-apt-repository -y ppa:ettusresearch/uhd
#sudo apt update
sudo apt -y install libuhd-dev libuhd003 uhd-host
sudo /usr/lib/uhd/utils/uhd_images_downloader.py


###########################################################################
#To install ASN.1 C compiler that turns the formal ASN.1 specifications into the C code:
#git clone https://github.com/mgp25/OpenBTS-UMTS
git clone https://github.com/RedesMovilesIoT/OpenBTS-UMTS.git
cd OpenBTS-UMTS/
mv asn1c-0.9.23.tar.gz ~/
cd
tar -xf asn1c-0.9.23.tar.gz
cd vlm-asn1c-0959ffb/
test -f configure || autoreconf -iv 
./configure 
make 
sudo make install
sudo ldconfig
cd

#OpenBTS uses the coredumper shared library to produce meaningful debugging information if OpenBTS crashes:

git clone https://github.com/RangeNetworks/libcoredumper.git
cd libcoredumper
sudo ./build.sh
sudo dpkg -i libcoredumper1_1.2.1-1_amd64.deb libcoredumper-dev_1.2.1-1_amd64.deb
cd
#2. OpenBTS-UMTS Installation
#To install OpenBTS-UMTS itself:
cd OpenBTS-UMTS
git submodule init
git submodule update
sudo NodeManager/install_libzmq.sh
./autogen.sh
./configure
make
sudo make install
sudo ldconfig

#3. OpenBTS-UMTS Configuration
#To setup OpenBTS-UMTS, it may be needed to modify the settings such as ARFCN, DNS, Firewall. Navigate to ~/OpenBTS-UMTS/apps folder and open OpenBTS-UMTS.example.sql file with the preferable text editor. You may need to edit following options:

cd apps/
#gedit OpenBTS-UMTS.example.sql 
cd
cd /etc/OpenBTS
sudo gedit OpenBTS-UMTS.example.sql


