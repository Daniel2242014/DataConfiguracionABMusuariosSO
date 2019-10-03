#!/bin/bash

# VERCION 3.0 - 25/10 PRIMERA ENTREGA desarrolado por Bit (3°BD 2019)

menuInformix()
{

eu1=('Instaladar_informix' 'Elminar_Informix' 'Restaurar_sysmaster')
eu2=('InsInformix' 'desInformix' 'sysmaster')	
	
menu 'eu1[@]' 'eu2[@]'	

ary1=(${nombres[@]})
ary2=(${direcionesSetUp[@]})

}

InsInformix()
{
	if ! test -d /opt/IBM/Informix_Software_Bundle
	then
		source /var/DataConfiguracionABMusuariosSO/informix_install.sh
	else
		echo "Ya tiene instalado informix, primero eliminelo para volver a instalar"
		read fff
	fi
}

desInformix()
{
	if test -d /opt/IBM/Informix_Software_Bundle
	then
		echo "¿Esta seguro que desea eliminar? [1=si, 0=no]"
		read fef
		case $fef in
		1)
			eliminacionRealInformix
			echo "Eliminacion terminada con exito" 
			read fff
		;;

		*)
			echo "No se eliminara" 
			read fff
		;;	

		esac 


	else
		echo "Informix no existe en el sistema"
		read fff
	fi
}


eliminacionRealInformix()
{
	rm -rf /etc/systemd/system/informix.service
	rm -rf /etc/sysconfig/informix
	sed -i '/sqlexec\|sqlturbo/d' /etc/services
	sed -i '/vmInformix/d' /etc/hostname
	sed -i '/192.168.1.100 vmInformix/d' /etc/hosts
	rm -rf /etc/profile.d/zz_configInformix.sh
	echo "Cargando...."
	/opt/IBM/Informix_Software_Bundle/uninstall/uninstall_server/uninstallserver -i console
        echo "Esperando a que termine eliminacion en segundo plano"
	sleep 3
	rm -rf /opt/IBM
	userdel informix
	groupdel informix
}
