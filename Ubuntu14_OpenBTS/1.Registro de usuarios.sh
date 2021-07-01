#Activar archivo .sh
#sudo chmod +x Nombre_archivo
#Ejecutar archivo .sh
#./Nombre_archivo
#########################################Terminal 2
echo "                           "
echo "Registro de usuarios"
echo "                           "
########Registro de usuarios
cd ~/dev/NodeManager
##Para agregar usuarios
##./nmcli.py sipauthserve subscribers create "nombre" IMSI”imsi” “número celular”
##//Ejem:
./nmcli.py sipauthserve subscribers create Usuario1 IMSI740130000000001 0900000001
./nmcli.py sipauthserve subscribers create Usuario3 IMSI740130000000003 0900000003
./nmcli.py sipauthserve subscribers create Usuario4 IMSI740130000000004 0900000004
##//Para leer los datos guardados
echo "                           "
echo "Para leer los datos guardados"
echo "                           "
./nmcli.py sipauthserve subscribers read
##//Para eliminar datos
##//Ejem:
##./nmcli.py sipauthserve subscribers delete imsi IMSI740130000000001

#########################################Terminal 3

#sip reload
#dialplan reload
#sip show peers
echo "                           "
echo "Para crear la base de datos de Asterisk"
echo "                           "
sudo asterisk -rx "database put IMSI IMSI740130000000001 0900000001"
sudo asterisk -rx "database put PHONENUMBER 0900000001 IMSI740130000000001"

sudo asterisk -rx "database put IMSI IMSI740130000000003 0900000003"
sudo asterisk -rx "database put PHONENUMBER 0900000003 IMSI740130000000003"

sudo asterisk -rx "database put IMSI IMSI740130000000004 0900000004"
sudo asterisk -rx "database put PHONENUMBER 0900000004 IMSI740130000000004"
#//Iniciamos la linea de comandos de Asterisk
#sudo asterisk -rvvvv

#//Para agregar usuarios en la base de datos de Asterisk
#//Ejemplo
#database put IMSI IMSI740130000000001 0501
#database put PHONENUMBER 052101 IMSI740130000000001

#database put IMSI IMSI740130000000002 0502
#database put PHONENUMBER 052102 IMSI740130000000002
#//Visualizacion de datos
echo "                           "
echo "Visualizacion de datos de Asterisk"
echo "                           "
sudo asterisk -rx "database show"

#En asterisk "database show"
#//Para eliminar datos 
#//Ejem:
#database del IMSI IMSI740130000000001
#database del PHONENUMBER 052101

#//#########################################Terminal 4
#//Respaldamos el archivo original
sudo cp /etc/asterisk/extensions.conf /etc/asterisk/extensions.conf.original
echo "                           "
echo "Agregar archivo para las extensiones sip"
echo "                           "
sudo gedit /etc/asterisk/extensions.conf
#//Se borra todo y se pega lo siguiente sin los numerales
#[from-openBTS]
#exten => _09X.,1,Verbose(Dialplan started)
#same = n,Set(CALLER_IMSI=${CALLERID(num)})
#same = n,Verbose(Get CID from CALLER_IMSI: ${CALLER_IMSI})
#same = n,Set(CID=${DB(IMSI/${CALLER_IMSI})})
#same = n,Set(CALLERID(num)=${CID})
#same = n,Verbose(Get IMSI from EXTEN: ${EXTEN})
#same = n,Set(IMSI=${DB(PHONENUMBER/${EXTEN})})
#same = n,Dial(SIP/00101100010/${IMSI})
#same = n,Hangup




