function crearLlaveSsh()
{
    verifUser
    usr=$respuesta
    if test -z "$usr"
    then
	return
    fi
    if test -f "~$usr/.ssh/authorized_keys"
    then
	echo "Este usuario ya tiene una clave SSH configurada. Si desea cambiarla utilice la función cambiar llave."
    else
	echo "Por favor, almacene la nueva clave privada del usuario en /tmp/pub_key-$usr.enc"
	read ff
	cp /tmp/pub_key-$usr.enc ~$usr/.ssh/authorized_keys
	chown $usr:root ~$usr/.ssh/authorized_keys
	chmod 644 ~$usr/.ssh/authorized_keys
	echo "Clave pública instalada en ~$usr/.ssh/authorized_keys!"
    fi
}
