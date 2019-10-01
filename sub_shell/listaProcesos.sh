#!/bin/bash
#VERCION 3.0 - 25/10 SEGUNDA ENTREGA desarrolado por Bit (3°BD 2019)

sendless()
{
	echo "Se listaran todos los prosesos, ingrese 'q' para salir de la lista"
	echo "Ingrese cualquier boton para salir" 
	read fff
}

function todosProcesos()
{
    sendless			
    ps axo uid,pid,ppid,stime,time,cmd | less
}

function procesosUsuario()
{
    respuesta="a"
    while [ "$respuesta" != "" ]
    do
	verifUser
	if [ "$respuesta" != "" ]
	then
	    pCount=$(ps -U "$respuesta" -o pid,comm=Proceso | wc -l)
	    if [ $pCount -eq 1 ]
	    then
		echo "No hay procesos abiertos por el usuario $respuesta"
	    else
		sendless
		ps -U "$respuesta" -o pid,comm=Proceso | less
	    fi
	fi
    done
}

function detalleProceso()
{
    input=0
    while [ $input -ge 0 ]
    do
	echo -n "Inserte un número de PID (menor que 0 saldrá de la función): "
	read input
	if test $input -le 0 2> /dev/null
	then
		echo "Cancelado, toque enter para continuar"		
		return 
	fi
	if test $(echo "$input" | grep -E "^[0-9]{1,9}$"|wc -l) -eq 1 && test $(ps --pid $input|wc -l) -eq 2
	then
        pCount=$(ps --pid $input -o comm=Proceso,%cpu=CPU,%mem=RAM,euid=UID_Efectivo,ruid=UID_Real | wc -l)
	    if [ $pCount -eq 0 ]
	    then
		echo "No hay procesos con PID=$input..."
		read k
	    else
		_ppid=$(ps --pid $input -o ppid | tail -1)
		 echo "Se listaran todos los prosesos, ingrese 'q' para salir de la lista"
	        echo "Ingrese cualquier boton para salir" 
	        read fff		
		ps --pid $input -o comm=Proceso,%cpu=CPU,%mem=RAM,euid=UID_Efectivo,ruid=UID_Real | less
		echo "1 para ver padre, 2 para ver hijos, 3 para salir"
		read k
		if [ "$(echo $k | grep -E "^[1-3]{1}$" | wc -l)" -eq 1 ]
		then
		    if [ $k -eq 1 ]
		    then
			#padre: proceso p / p.pid=input.ppid
			 echo "Se listaran todos los prosesos, ingrese 'q' para salir de la lista"
			echo "Ingrese cualquier boton para salir" 
			read fff
			ps --pid $_ppid -o comm=Proceso,%cpu=CPU,%mem=RAM,euid=UID_Efectivo,ruid=UID_Real | less 
			echo "Enter para continuar..."
			read k
		    elif [ $k -eq 2 ]
		    then
			#hijos: proceso p / input.pid=p.ppid
			echo "Se listaran todos los prosesos, ingrese 'q' para salir de la lista"
			echo "Ingrese cualquier boton para salir" 
			read fff
			ps --ppid $input -o comm=Proceso,%cpu=CPU,%mem=RAM,euid=UID_Efectivo,ruid=UID_Real, pid=PID | less 
			echo "Enter para continuar..."
			read k
		    fi
		fi
	    fi
	else
            echo "Proseso no encontrado" 
	fi
    done
}

#ps --pid $(ps --pid 2 -o ppid=PPID) -o comm=pro
ps --pid 2 -o ppid=PPID | tail -n1 | sed "s/^[ ]*\(.*\)$/\1/"


verificarPID()
{
     if test $(ps axo pid | grep  " $1$"|wc -l) -eq 0
	then
		return 0
	else
		return 1
	fi

}

devolverHijos()
{
	sendless
  	ps --ppid $input -o comm=Proceso,%cpu=CPU,%mem=RAM,pid=PID,ppid=PPID|less 
}

ComprobarEHijo()
{
	if test $(ps --ppid $1 -o pid=PID 2> /dev/null| wc -l) - gt 1
	then
		return 1
	else
		return 0
	fi 
}

ComprobarEPadre()
{
	if test $(ps --pid $(ps --pid $1 -o ppid=PPID | tail -n1 | sed "s/^[ ]*\(.*\)$/\1/"|tail -n1) -o --pid=PID| wc -l) - gt 1
	then
		return 1
	else
		return 0
	fi 
}

devolverPadre()
{
	sendless
	ps --pid $(ps --pid $1 -o ppid=PPID | tail -n1 | sed "s/^[ ]*\(.*\)$/\1/"|tail -n1) -o comm=Proceso,%cpu=CPU,%mem=RAM,pid=PID,ppid=PPID|less
}


function listaProcesos()
{
	heh=0
    	while test $heh -eq 0
	do
		echo "1) Ver todos los prosesos"
		echo "2) Panel de informacion completa por PID"
		echo "3) Bucar por nombre de Usuario"
		echo "4) Buscar hijos por PID de padre"
		echo "5) Buscar padre por PID de Hijo"
		echo "0) Salir"	
		read data
		case in $data
			1)	
				todosProcesos
			;;
			2)
				detalleProceso
			;;
			3)
				procesosUsuario
			;;
			4)
				ente=0
				while test $ente -eq 0
				do
					echo "Ingrese el PID del proseso a buscar - 0 para salir"
					read entrada
					if test $(echo $entrada|grep -e "^[1-9][0-9]*$"| wc -l) -eq 1
					then
						verificarPID $entrada
						if test $? -eq 1
						then
							ComprobarEHijo $entrada 
							if test $? -eq 1 
							then

							else

							fi	
						else
							echo "Error: PID no encontrado"
						fi
					else					
						echo "Error: Formato invalido"
					fi		 
				done
			;;
			5)


			;;

			0)
				heh=1
			;;

			*)

			;;
		esac 

	done
}
