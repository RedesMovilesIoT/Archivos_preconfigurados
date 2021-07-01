#Activar archivo .sh
#sudo chmod +x Nombre_archivo
#Ejecutar archivo .sh
#./Nombre_archivo
echo "                           "
echo "Reiniciar servicios de Asterisk"
echo " 				 "
sudo asterisk -rx "sip reload"
sudo asterisk -rx "dialplan reload"
sudo asterisk -rx "sip show peers"
#Si el archivo no funciona se debe hacer de forma manual entrando a asterisk
#
#	$ sudo asterisk -rvvv
#		Y dentro de la linea de comandos de Asterisk lo siguiente:
#	sip reload
#	dialplan reload
#	sip show peers


