#/bin/bash
################################Instalación de dependencias 
echo "                           "
echo "Instalación de dependencias"
echo "                           "
sudo apt-get -y install pcscd pcsc-tools libccid libpcsclite-dev libusb-1.0-0-dev make automake cmake
################################Instalación de controlador genérico CCID
#El fichero requerido con los archivos de configuración se los obtiene en la siguiente dirección https://ccid.apdu.fr/files/ de la 
#cual se descarga la ultima versión que es la 1.4.33 o se puede obtener de la siguiente manera:
echo "             "
echo "Crear carpeta"
echo "             "
mkdir Controladores_y_herramientas_para_OMNIKEY_y_Pysim
cd Controladores_y_herramientas_para_OMNIKEY_y_Pysim
wget https://ccid.apdu.fr/files/ccid-1.4.33.tar.bz2
tar -xf ccid-1.4.33.tar.bz2
cd ccid-1.4.33
echo "             "
echo "Configure"
echo "             "
sudo ./configure
echo "             "
echo "make"
echo "             "
sudo make
echo "             "
echo "make install"
echo "             "
sudo make install
cd ../
#########################Instalación de controlador de HID OMNIKEY 3121
#A continuación, se descarga desde la página oficial de HID https://www.hidglobal.mx/drivers la versión más 
#reciente del controlador para el sistema operativo Ubuntu, en este caso se configura marca OMNIKEY, producto
#HID OMNIKEY 3121 Reader Board USB; la versión descargada es: HID® OMNIKEY® LINUX DRIVER FOR 8051 CONTROLLER BASED READERS V.4.3.3 
#para una arquitectura de 64 bits o se la puede obtener de la siguiente forma:
echo "             "
echo "Crear carpeta"
echo "             "
mkdir omnikey_ccid_driver_for_8051_controller_based_readers_v.4.3.3
cd omnikey_ccid_driver_for_8051_controller_based_readers_v.4.3.3
wget https://www.hidglobal.mx/sites/default/files/drivers/omnikey_ccid_driver_for_8051_controller_based_readers_v.4.3.3.zip
unzip omnikey_ccid_driver_for_8051_controller_based_readers_v.4.3.3.zip
tar -xf ifdokccid_linux_x86_64-4.3.3-3-a973c36ed296.tar.gz
cd ifdokccid_linux_x86_64-4.3.3-3-a973c36ed296
echo "             "
echo "Instalar controlador"
echo "             "
sudo chmod 755 install
sudo ./install
cd
sudo reboot
