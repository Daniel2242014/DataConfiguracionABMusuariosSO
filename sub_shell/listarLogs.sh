#!/bin/bash
#VERCION 2.0 - 4/8 SEGUNDA ENTREGA desarrolado por Bit (3°BD 2019)
function listarWtmp()
{
    echo "Ingrese 1 para buscar por todo, 2 buscar por usuario . O salir "
    read dar
    case $dar in 
	1)
		last -i | less

	;;
	2)
		verifUserTODO
		    usr=$respuesta
		    echo "Para salir de la sigiente lista ingrese 'q'. Para continuar ingrese cualquier tecla"
		    read fff
		    for i in $(ls /var/log/wtmp*); do
			    last -f $i $usr | head -n -2 | less #Lista los logs corespondientes 
		    done
	;;
	3)
		#buscarPorangoDeFechas '0'
	;;
	0)
		echo "volviendo al menu"
	;;

	*)
		echo "Ingreso incorrecto, se sale"
	;;

	esac	

    
}

function listarBtmp()
{
    echo -n "Inserte el usuario cuyos loggeos fallidos desea ver (o deje vacío para ver todos): "
    verifUserTODO
    usr=$respuesta
    echo "Para salir de la sigiente lista ingrese 'q'. Para continuar ingrese cualquier tecla"
    read fff
    for i in $(ls /var/log/btmp*); do
	    lastb -f $i $usr | head -n -2 | less less #Lista los logs corespondientes 
    done
}

buscarPorangoDeFechas()
{
     cambiarExUser '3' #Ingreso del limite inferior 
	if test $(echo $respuesta| grep -e "POR DEFECTO"| wc -l) -eq 1 
							then 
								echo "Operacion cancelada"
							else
								fech=$respuesta							
								cambiarExUser '4' #Ingreso del limite superior
								if test $(echo $respuesta| grep -e "POR DEFECTO"| wc -l) -eq 1 
								then 
									echo "Operacion cancelada"
								else
									fech2=$respuesta
									touch $carpetaBase/Temp/listar
									if test $1 -eq 0
									then
										last -i | head -n$[$(cat last -i| wc -l)-2]| while read var2
										do					
											data44=$(echo $var2| cut -c19-34)
											#echo $data44
											if test $(date -d"$data44" +%s) -ge $(date -d"$fech" +%s 2> /dev/null) 2> /dev/null && test $(date -d"$data44" +%s) -le $(date -d"$fech2" +%s 2> /dev/null) 2> /dev/null
												then
													echo $var2 >> $carpetaBase/Temp/listar #cargamos los datos

												fi 
											
										done
									else
										lastb -i | head -n$[$(cat last -i| wc -l)-2]| while read var2
										do								
											if test $(date -d"$(echo $var2| cut -c19-34)" +%s) -ge $(date -d"$fech" +%s 2> /dev/null) 2> /dev/null && test $(date -d"$(echo $var2| cut -c19-34)" +%s) -le $(date -d"$fech2" +%s 2> /dev/null) 2> /dev/null
												then
													echo $var2 >> $carpetaBase/Temp/listar #cargamos los datos

												fi 
										done
									fi
									
									if test $(wc -l $carpetaBase/Temp/listar|cut -d" " -f1) -eq 0
									then
										echo "Sin resultados, toque cualquier boton para continuar"
										read f
									else
										less $carpetaBase/Temp/listar #los mostramos 
									fi
									rm -f $carpetaBase/Temp/listar
								fi
							fi
}
