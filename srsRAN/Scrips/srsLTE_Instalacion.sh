#/bin/bash
###############################Instalacion de drivers UHD para USRP B210
echo "                           "
echo "Instalación de UHD"
echo "                           "
sudo add-apt-repository -y ppa:ettusresearch/uhd
sudo apt update
sudo apt -y install libuhd-dev libuhd003 uhd-host
sudo /usr/lib/uhd/utils/uhd_images_downloader.py
################################Instalación de dependencias 
echo "                           "
echo "Instalación de dependencias"
echo "                           "
sudo apt -y install cmake libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev git
################################Instalación de srsLTE
cd
git clone https://github.com/srsran/srsRAN.git
cd srsRAN
#git checkout release_19_12
git checkout release_20_10_1
git rev-parse HEAD
##d045213fb9cbf98c83c06d7c17197a9dcbfddacf   release_19_12
##45486b6e2c622ab1d47906521662f087816d7d03   release_20_10_1
mkdir build
cd build
echo "             "
echo "cmake ../"
echo "             "
cmake ../
echo "             "
echo "make"
echo "             "
make
echo "             "
echo "make test"
echo "             "
make test
echo "             "
echo "sudo make install"
echo "             "
sudo make install
sudo ldconfig
################################Pasos Complementarios
echo "             "
echo "Pasos complementarios"
echo "             "
cd
cd srsRAN
##########Para el srsEPC
cp srsepc/epc.conf.example srsepc/epc.conf
cp srsepc/user_db.csv.example srsepc/user_db.csv
#############Para el srsENB
cp srsenb/enb.conf.example srsenb/enb.conf
cp srsenb/rr.conf.example srsenb/rr.conf
cp srsenb/sib.conf.example srsenb/sib.conf
cp srsenb/drb.conf.example srsenb/drb.conf


