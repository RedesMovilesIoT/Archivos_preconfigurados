sudo apt-get update
sudo apt-get -y install libreadline6-dev bind9 ntp autoconf libboost-all-dev ntpdate git cmake python-mako build-essential
sudo add-apt-repository ppa:ettusresearch/uhd-3.9.lts
sudo apt update
sudo apt -y install libuhd-dev libuhd003 uhd-host
#sudo /usr/lib/uhd/utils/uhd_images_downloader.py
wget http://files.ettus.com/binaries/images/uhd-images_003.009.007-release.zip
unzip uhd-images_003.009.007-release.zip
cd uhd-images_003.009.007-release/share/
sudo cp -r uhd/ /usr/share/

#Instalar OpenBTS
git clone https://github.com/RangeNetworks/dev.git
cd dev
./clone.sh
./switchto.sh master

######En la misma terminal, y con la finalidad de garantizar funcionalidad entre todos los elementos, ejecutar:

cd liba53
sudo make install
sudo ldconfig
cd ..
#####Se incluye el repositorio encargado de que funcione correctamente smqueue:
sudo apt-get install software-properties-common python-software-properties
sudo add-apt-repository ppa:chris-lea/zeromq
sudo apt-get update
###A continuación, se procede a compilar todo el proyecto, este procedimiento se tarda en base a las características técnicas del equipo usado (hardware) y de la conexión a internet.
####Se modifican con un editor de texto el archivo build.sh ya que hay una dependencia que no se cumple, se puede reemplazar la línea 133 por la siguiente:
#gedit build.sh
##installIfMissing libzmq5 // original, se borra
##installIfMissing libzmq3 // esta se incluye(linea 133)
##Se dejan como comentario o se eliminan las siguientes líneas (135 a 139)
##if [ "$MANUFACTURER" == "Ettus" ]; then
##installIfMissing libuhd-dev
##installIfMissing libuhd003
##installIfMissing uhd-host
##fi

# o lo siguiente hara el proceso
sed -i 's/installIfMissing libzmq5/installIfMissing libzmq3/' build.sh
sed -i '135c\#if [ "$MANUFACTURER" == "Ettus" ]; then' build.sh
sed -i 's/installIfMissing libuhd-dev/#installIfMissing libuhd-dev/' build.sh
sed -i 's/installIfMissing libuhd003/#installIfMissing libuhd003/' build.sh
sed -i 's/installIfMissing uhd-host/#installIfMissing uhd-host/' build.sh
sed -i '139 s/fi/#fi/' build.sh
sed -i '143c\BUILDNAME="BUILDS/const"' build.sh


./build.sh B210
##De presentarse algún problema de dependencias entre paquetes, o error donde se aborte inesperadamente el procedimiento, ejecutar la siguiente línea de comando:
##$ sudo apt-get -f install

cd BUILDS/const
##Se ingresa a dicha carpeta indicando el nombre desde la terminal.
##$ cd "nombre de carpeta"
##En esta ubicación se encuentran los archivos *.deb a instalar, se debe ejecutar desde la terminal:
sudo dpkg -i *.deb
#sudo dpkg -i *.deb
##Esperar y luego, si no aparecen errores, estará OpenBTS correctamente instalado.

