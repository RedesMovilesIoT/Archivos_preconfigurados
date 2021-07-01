#Para correr archivo .sh
#Ejemplo
#sudo chmod +x Archivo.sh
#Es mejor hacer esto en diferentes terminales 
#./Archivo.sh

#A continuación, actualice su sistema Ubuntu e instale los siguientes paquetes que son necesarios #para descargar y construir Asterisk  
sudo apt update
sudo apt install -y wget build-essential subversion
#Descargue la última versión de Asterisk 15 usando el siguiente comando wget :
wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-15.0.0-rc1.tar.gz
#Una vez completada la descarga, extraiga el archivo tar con:
tar xvf asterisk-15.0.0-rc1.tar.gz
#Antes de continuar con los siguientes pasos, asegúrese de cambiar al directorio de origen de Asterisk escribiendo:
cd asterisk-15.0.0-rc1/
#Instalación de dependencias de Asterisk
#La siguiente secuencia de comandos descargará las fuentes de MP3 necesarias para compilar el módulo MP3 y utilizar archivos MP3 en Asterisk:
contrib/scripts/get_mp3_source.sh
sudo sed -i '111 s/		apt-get install aptitude/		apt-get install -y aptitude/' ~/asterisk-15.0.0-rc1/contrib/scripts/install_prereq
sudo contrib/scripts/install_prereq install
#Use el install_prereqscript para resolver todas las dependencias en su sistema Ubuntu:
echo "                           "
echo "Install"
echo "                           "

#La secuencia de comandos instalará todos los paquetes necesarios y, una vez completada con éxito, imprimirá el siguiente mensaje:
 #############################################
   ## install completed successfully
   #############################################
#Instalación de Asterisk en el Sistema operativo
#La secuencia configure de comandos realizará una serie de comprobaciones para asegurarse de que todas las dependencias de su sistema estén presentes, inicie la secuencia de comandos escribiendo:
./configure

##################################################################################

#Menuselect build configuration successfully completed
#
#               .$$$$$$$$$$$$$$$=..      
#            .$7$7..          .7$$7:.    
#          .$$:.                 ,$7.7   
#        .$7.     7$$$$           .$$77  
#     ..$$.       $$$$$            .$$$7 
#    ..7$   .?.   $$$$$   .?.       7$$$.
#   $.$.   .$$$7. $$$$7 .7$$$.      .$$$.
# .777.   .$$$$$$77$$$77$$$$$7.      $$$,
# $$$~      .7$$$$$$$$$$$$$7.       .$$$.
#.$$7          .7$$$$$$$7:          ?$$$.
#$$$          ?7$$$$$$$$$$I        .$$$7 
#$$$       .7$$$$$$$$$$$$$$$$      :$$$. 
#$$$       $$$$$$7$$$$$$$$$$$$    .$$$.  
#$$$        $$$   7$$$7  .$$$    .$$$.   
#$$$$             $$$$7         .$$$.    
#7$$$7            7$$$$        7$$$      
# $$$$$                        $$$       
#  $$$$7.                       $$  (TM)     
#   $$$$$$$.           .7$$$$$$  $$      
#     $$$$$$$$$$$$7$$$$$$$$$.$$$$$$      
#       $$$$$$$$$$$$$$$$.                
#
#configure: Package configured for: 
#configure: OS type  : linux-gnu
#configure: Host CPU : x86_64
#configure: build-cpu:vendor:os: x86_64 : pc : linux-gnu :
#configure: host-cpu:vendor:os: x86_64 : pc : linux-gnu :
##################################################################################
#El siguiente paso es seleccionar los módulos que desea compilar e instalar. Acceda al sistema Menuselect escribiendo:
make menuselect
#Ya hemos descargado los archivos fuente de MP3 y ahora debemos decirle a Asterisk que compile el módulo de MP3 seleccionando format_mp3.
#Una vez que haya terminado, presione F12 para guardar y salir, o cambie al Save and Exit botón y presione Enter.
#Ahora podemos iniciar el proceso de compilación usando el make comando:
make -j2
# +--------- Asterisk Build Complete ---------+
# + Asterisk has successfully been built, and +
# + can be installed by running:              +
# +                                           +
# +                make install               +
# +-------------------------------------------+
#Como dice el mensaje anterior, el siguiente paso es instalar Asterisk y sus módulos escribiendo:
sudo make install
# +---- Asterisk Installation Complete -------+
# +                                           +
# +    YOU MUST READ THE SECURITY DOCUMENT    +
# +                                           +
# + Asterisk has successfully been installed. +
# + If you would like to install the sample   +
# + configuration files (overwriting any      +
# + existing config files), run:              +
# +                                           +
# + For generic reference documentation:      +
# +    make samples                           +
# +                                           +
# + For a sample basic PBX:                   +
# +    make basic-pbx                         +
# +                                           +
# +                                           +
# +-----------------  or ---------------------+
# +                                           +
# + You can go ahead and install the asterisk +
# + program documentation now or later run:   +
# +                                           +
# +               make progdocs               +
# +                                           +
# + **Note** This requires that you have      +
# + doxygen installed on your local system    +
# +-------------------------------------------+
#Instale cualquiera de los archivos de configuración genéricos con documentación de referencia escribiendo:
sudo make samples ###################3
#O instale los archivos de configuración básicos de PBX:
#sudo make basic-pbx
#El último paso es instalar el script de inicio de Asterisk escribiendo:
sudo make config
#También es una buena idea ejecutar ldconfig para actualizar la memoria caché de las bibliotecas compartidas:
sudo ldconfig
###########################Creación de un usuario de Asterisk
#Por defecto, Asterisk se ejecuta como usuario root. Por razones de seguridad, crearemos un nuevo usuario del sistema y configuraremos Asterisk para que se ejecute como el nuevo usuario creado.
#Para crear un nuevo usuario del sistema llamado Asterisk ejecute el siguiente comando:
sudo adduser --system --group --home /var/lib/asterisk --no-create-home --gecos "Asterisk PBX" asterisk 
#Para configurar Asterisk para que se ejecute como Asterisk usuario, abra el archivo /etc/default/asterisk y descomente las siguientes dos líneas:
###########################sudo gedit /etc/default/asterisk#######################
#Quitar el  numeral en las 2 lineas como las siguiente:
#AST_USER="asterisk"
#AST_GROUP="asterisk"
sudo sed -i '8 s/#AST_USER="asterisk"/AST_USER="asterisk"/' /etc/default/asterisk
sudo sed -i '9 s/#AST_GROUP="asterisk"/AST_GROUP="asterisk"/' /etc/default/asterisk
#Agregue el Asterisk usuario a los grupos dialout y audio:
sudo usermod -a -G dialout,audio asterisk	
#También debemos cambiar la propiedad de todos los archivos y directorios de asterisco para que el usuario pueda acceder a esos archivos:
sudo chown -R asterisk: /var/{lib,log,run,spool}/asterisk /usr/lib/asterisk /etc/asterisk
sudo chmod -R 750 /var/{lib,log,run,spool}/asterisk /usr/lib/asterisk /etc/asterisk
#Asterisk de arranque
#Ahora que estamos configurados, podemos iniciar el servicio de Asterisk con el siguiente comando:
sudo service asterisk start
#sudo service asterisk status
sudo cp /etc/asterisk/sip.conf /etc/asterisk/sip.conf.ori
sudo cp /etc/asterisk/extensions.conf /etc/asterisk/extensions.conf.ori
sudo rm /etc/asterisk/sip.conf
sudo rm /etc/asterisk/extensions.conf
#Para el correcto funcionamiento de Asterisk se tienen que activar los módulos en: gedit /etc/asterisk/modules.conf cambiando de No a Yes. En caso de que este en No.
#De igual forma se tiene que eliminar el archivo pjsip.conf con el comando sudo nautilus entrando a la carpeta de la dirección cd /etc/asterisk/ y se busca el archivo pjsip.
sudo cp /etc/asterisk/pjsip.conf /etc/asterisk/pjsip.conf.ori
sudo rm /etc/asterisk/pjsip.conf
#################Ahora procedemos a realizar la configuración del Firewall
#El firewall protegerá su servidor contra el tráfico no deseado.
#Si no tiene un servidor de seguridad configurado en su servidor, puede consultar nuestra guía sobre cómo configurar un servidor de seguridad con ufw en ubuntu
#De forma predeterminada, SIP utiliza el puerto UDP 5060 para abrir la ejecución del puerto:
sudo ufw allow 5060/udp
#Si habilitó el Protocolo en tiempo real (RTP), también deberá abrir el siguiente rango de puertos:
sudo ufw allow 10000:20000/udp
cd
git clone https://github.com/RedesMovilesIoT/Archivos_preconfigurados.git
cd Archivos_preconfigurados/
cd Asterisk/
sudo cp sip.conf /etc/asterisk/sip.conf
sudo cp extensions.conf /etc/asterisk/extensions.conf
cd 
rm -r Archivos_preconfigurados/
#Esto es necesario nuevamente ya que se asterisk-15.0.0-rc1/han copiado archivos y es necesario dar permisos otra ves
sudo chown -R asterisk: /var/{lib,log,run,spool}/asterisk /usr/lib/asterisk /etc/asterisk
sudo chmod -R 750 /var/{lib,log,run,spool}/asterisk /usr/lib/asterisk /etc/asterisk
#sudo su
#cd /etc/asterisk/
sudo systemctl restart asterisk
sudo systemctl status asterisk
#sudo asterisk -vvvr
#sudo service asterisk stop
#sudo service asterisk start
#sudo service asterisk status
#o probar con esta lìnea
#sudo systemctl start asterisk

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
#Luego para probar astareisk poner $ sudo asterisk -vvvr 
#Para reiniciar servicios en asterisk
#sudo asterisk -rx  "sip reload"
#sudo asterisk -rx  "dialplan reload"
#sudo asterisk -rx  "sip show peers"
sudo asterisk -rx 'sip reload'
sudo asterisk -rx 'dialplan reload'
sudo asterisk -rx 'sip show peers'
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#





