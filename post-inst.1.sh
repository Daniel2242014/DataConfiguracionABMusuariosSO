# Version 2.0 4/8 SEGUNDA ENTREGA Bit
#ANTES DE CORRER ESTE SCRIPT:
# monte o descomprima informix en /ifx_installer

systemctl stop firewalld
systemctl disable firewalld
systemctl stop NetworkManager
systemctl disable NetworkManager
yum remove NetworkManager firewalld
yum install policycoreutils-python git

# TODO: comando para descargar informix;
# agregar cuando se encuentra una solución a los problemas del servidor

#mkdir informix_installer
#tar xvf informix.tar -C informix_installer

#cd informix_installer

sh informix_install.sh
echo "Su sistema se reiniciará tras el script de postinstalación, si necesita terminar de configurar algún otro subsistema haga CTRL+z, termine dicho proceso y vuelva a la instalación con fg"
read a
sh informix_postinstall.sh
