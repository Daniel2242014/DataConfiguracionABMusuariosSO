#P2

sh informix_postinstall2.sh

echo -n "Desea configurar el entorno de red? (Y/n): "
read sel
if [ "$sel" != "n" ]
then
	source sub_shell/configurarRed.sh
	configurarRed
fi

source setup.sh
