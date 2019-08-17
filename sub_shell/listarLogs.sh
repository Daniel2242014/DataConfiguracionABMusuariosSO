function listarWtmp()
{
    echo -n "Inserte el usuario cuyos loggeos exitosos desea ver (o deje vacío para ver todos): "
    verifUser
    usr=$respuesta
    last $usr | head -n -2
    read ff
}

function listarBtmp()
{
    echo -n "Inserte el usuario cuyos loggeos fallidos desea ver (o deje vacío para ver todos): "
    verifUser
    usr=$respuesta
    lastb $usr | head -n -2
    read ff
}
