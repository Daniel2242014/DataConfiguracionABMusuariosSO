systemctl stop firewalld
systemctl disable firewalld
systemctl stop NetworkManager
systemctl disable NetworkManager
yum remove NetworkManager
yum remove firewalld
yum install policycoreutils-python

# TODO: comando para descargar informix;
# agregar cuando se encuentra una solución a los problemas del servidor

#mkdir informix_installer
#tar xvf informix.tar -C informix_installer

#cd informix_installer

source setup.sh

echo -n "Desea configurar el entorno de red? (Y/n): "
read sel
if [ "$sel" != "n" ]
then
	source sub_shell/configurarRed.sh
	configurarRed
fi
