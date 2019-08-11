function cambiarLlave()
{
    echo -n "Sólo podrá cambiar su clave si posee la clave anterior. Desea continuar? [S/n] "
    read input
    if [ "$input" == "S" ];
    then
	head /dev/urandom | tr -dc A-Za-z0-9 | head -c10 > /tmp/pwd
	mypwd=$(cat /tmp/pwd)
	openssl rand -out /tmp/skey 32
	openssl aes-256-cbc -in /tmp/pwd -out /tmp/pwd.enc -pass file:/tmp/pwd
	openssl rsautl -encrypt -oaep -pubin -inkey <(ssh-keygen -e -f ~/.ssh/id_rsa.pub -m PKCS8) -in /tmp/skey -out /tmp/skey.enc
	rm /tmp/skey
	rm /tmp/pwd
	echo "Conectese via scp al servidor y copie los archivos '/tmp/{pwd.enc, skey.enc}' a su computadora."
	echo "Utilizando su clave privada, desencripte skey.enc. En OpenSSL, el comando es 'openssl rsautl -decrypt -oaep -inkey <archivo de clave privada> -in skey.enc -out skey'"
	echo "En 'skey' tendrá un archivo que utilizará como clave simétrica. Usando la misma, desencripte pwd.enc. En OpenSSL, el comando es 'openssl aes-256-cbc -d -in pwd.enc -out pwd.txt -pass file:skey'. En 'pwd.txt', tendrá una clave de 10 caracteres. Insértela a continuación para verificar que usted posee la clave privada actual."
	echo -n "Clave de 10 caracteres: "
	read -s pass
	if [ "$pass" == "$mypwd" ];
	then
	    echo "La clave fue validada con éxito"
	    echo -n "Inserte la contraseña de la nueva clave privada: "
	    read newpwd
	    ssh-keygen -b 2048 -t rsa -n "$newpwd" -f ~/.ssh/newkey
	    echo "Conéctese via scp y copie a su computadora el archivo '/root/.ssh/newkey'. El mismo es su nueva clave privada. También puede copiar el archivo '/root/.ssh/newkey.pub' si desea utilizar esta clave pública en otros servidores. UNA VEZ QUE USTED CONFIRME, SERÁ ELIMINADA LA CLAVE PRIVADA DE ESTE SERVIDOR."
	    cf="n"
	    while [ "$cf" != "Y" ]
	    do
		echo -n "Listo? [Y/n] "
		read cf
	    done
	    rm ~/.ssh/newkey
	    mv ~/.ssh/newkey.pub ~/.ssh/authorized_keys
	    echo "Su nueva llave ha sido configurada. Por favor conéctese nuevamente."
	else
	    echo "No pudo validarse la clave."
	fi
    fi
}
