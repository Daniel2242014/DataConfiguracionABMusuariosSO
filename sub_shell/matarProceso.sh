#version 2 segunda entrega
function killProc()
{
    echo -n "PID del proceso a matar: "
    read pid
    if ! echo $pid | grep -E "^[0-9]{1,9}$"
    then
	echo "No es un número de PID válido"
    fi
    if ! kill $pid
    then
	echo "No se pudo matar al proceso $pid"
    else
	echo "Proceso $pid tumbado con éxito"
    fi
}
