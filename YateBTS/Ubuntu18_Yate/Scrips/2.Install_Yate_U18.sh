#Para Habilitar archivos bash
#En un terminal
#sudo chmod +x "archivo"
#./"archivo"
################# Instalar YateBTS en ubuntu18.04 continuacion
#Agregar / editar archivos
#Aquí es donde entra en uso el grupo yate . Cambiamos el propietario de los archivos de configuración de root a yate .
sudo touch /usr/local/etc/yate/snmp_data.conf /usr/local/etc/yate/tmsidata.conf
sudo chown root:yate /usr/local/etc/yate/*.conf
sudo chmod -R a+rw /usr/local/etc/yate
#sudo gedit /etc/security/limits.conf
##add these values
#@yate hard nice -20
#@yate hard rtprio 99
sudo sed -i '$a\@yate hard nice -20' /etc/security/limits.conf
sudo sed -i '$a\@yate hard rtprio 99' /etc/security/limits.conf

#Vincular la GUI web a Apache (opcional)
#La GUI se encuentran en /usr/local/etc/yate, siendo los archivos más importantes ybts.confy #subscribers.conf.

cd /var/www/html
#sudo ln -s /usr/local/share/yate/nib_web/ nib
sudo ln -s /usr/local/share/yate/nipc_web/ nipc
cd
wget https://www.nuand.com/fpga/v0.9.0/hostedx115.rbf
#Opciones de GUI web
#En un navegador web, 
#localhost/nipc
