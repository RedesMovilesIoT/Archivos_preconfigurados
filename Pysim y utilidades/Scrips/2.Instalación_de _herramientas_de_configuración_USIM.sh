#/bin/bash
################################Instalación de dependencias
echo "                           "
echo "Instalación de dependencias"
echo "                           "
cd Controladores_y_herramientas_para_OMNIKEY_y_Pysim
sudo apt-get -y install python-pip python-setuptools python-dev python-augeas gcc swig dialog git
sudo python -m pip install serial pycrypto
##################################Instalación de Pyscard
#Se descarga la última versión disponible en la página oficial: https://sourceforge.net/projects/pyscard/files/pyscard/ 
#siendo la ultima versión para Ubuntu la 1.9.5 o se la puede obtener de la siguiente manera:
wget https://versaweb.dl.sourceforge.net/project/pyscard/pyscard/pyscard%201.9.5/pyscard-1.9.5.tar.gz
tar -xf pyscard-1.9.5.tar.gz
cd pyscard-1.9.5
echo "                           "
echo "Instalación de pyscard"
echo "                           "
sudo python setup.py build_ext install
cd
#Se procedera a descargar la versión de Pysim de la rama de Diciembre de 2019 desde el 
#repositorio de osmocom ya que la última versión tiene problemas por falta de dependencias:
echo "                           "
echo "Obtencion de Pysim"
echo "                           "
git clone https://github.com/osmocom/pysim.git --branch pmaier/wip
cd pysim
sudo chmod 755 pySim-read.py
echo "                           "
echo "Lectura de la USIM"
echo "                           "
#./pySim-read.py -p 0
exit

