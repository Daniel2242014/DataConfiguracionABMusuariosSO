#version 2 segunda entrega bit
function todosProcesos()
{
    ps -o pid,ruser=Usuario,comm=Proceso a
}

function procesosUsuario()
{
    respuesta="a"
    while [ "$respuesta" != "" ]
    do
	verifUser
	if [ "$respuesta" != "" ]
	then
	    ps -U "$respuesta" -o pid,comm=Proceso
	    read ff
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
	if ! echo input | grep -E "^[0-9]{1,9}$"
	then
	    input=-1
	else
	    ps --pid $input -o comm=Proceso,%cpu=CPU,%mem=RAM,euid=UID_Efectivo,ruid=UID_Real
	fi
    done
}

function listaProcesos()
{
    echo -n "Desea ver procesos de todo el sistema (1), de un usuario (2), o detalles de un proceso (3)? "
    read input
    if [ $input -eq 1 ]
    then
	todosProcesos
    elif [ $input -eq 2 ]
    then
	procesosUsuario
    else
	detalleProceso
    fi
    read ff
}
