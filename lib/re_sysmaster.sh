#!/bin/bash

# VERCION 3.0 - 25/10 PRIMERA ENTREGA desarrolado por Bit (3°BD 2019)

sysmaster()
{
if test -d /opt/IBM/Informix_Software_Bundle/
then
	verif=0
	if ! test -e /opt/IBM/Informix_Software_Bundle/etc/sysmaster.sql
	then
		verif=1
	else
		if test -z $1 || test $1 -eq 0
		then 
			echo "Sysmaster.sql ya existe, ¿desea continuar? [1=si 0= no]"		
			read dato 		
			if test $dato -eq 1 2>/dev/null
			then
				verif=1
			fi
		fi
	fi

	if test $verif -eq 1
	then 
		if test -e /opt/IBM/Informix_Software_Bundle/etc/conv/rebuildsmi.sh
		then
			su informix -c "sh /opt/IBM/Informix_Software_Bundle/etc/conv/rebuildsmi.sh"
			read fff
		else
			echo "ERROR CRITICO: no se encuentra el documento rebuildsmi.sh, por favor solucione y vuelva a ejecutar, sujerimos reinstalar informix"
			echo "Toque cualquier boton para salir " 
			read fff
		fi 
 		
	fi
else
echo "Instale informix primero "
		read fff
fi

}
