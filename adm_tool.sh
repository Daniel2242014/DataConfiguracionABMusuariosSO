if test $(git --help 2>/dev/null | wc -l ) -ne 0
then
    if test $USER = "root" # Debe ser el usuario root quien utilice el shell 
    then
	if test test $(echo $PATH | grep "/var/DataConfiguracionABMusuariosSO/"|wc -l) -eq 1 && ! test -f /etc/profile.d/z_ABMConfiguration.sh
	then
	    echo "El sistema ha sido eliminado utilizando setup llamado con el comando sh"
	    echo "Use el comando 'exit' para volver a ingresar al sistema y luego ejecute este software nuevamente"
	else
	    if ! test $(echo $PATH | grep "/var/DataConfiguracionABMusuariosSO/"|wc -l) -eq 1 &&  test -f /etc/profile.d/z_ABMConfiguration.sh
	    then
		echo "ha instalado el sistema sin usar source, salga y vuelva a ingresar al sistema"
	    else
		if test $(echo $PATH | grep "/var/DataConfiguracionABMusuariosSO/"|wc -l) -eq 1  #revisa que este la ubicacion de la instalacion 
		then
		    clear
		    #Se importan un conjunto de archivos llenos de metodos a utilizar en la ABM
		    source /var/DataConfiguracionABMusuariosSO/lib/lib_menu.sh
		    source /var/DataConfiguracionABMusuariosSO/lib/DT.sh
		    source /var/DataConfiguracionABMusuariosSO/lib/expiracionUsuario.sh
		    source /var/DataConfiguracionABMusuariosSO/lib/GP.sh
		    source /var/DataConfiguracionABMusuariosSO/lib/GS.sh
		    source /var/DataConfiguracionABMusuariosSO/lib/NDiasHasta.sh
		    source /var/DataConfiguracionABMusuariosSO/lib/pass.sh
		    source /var/DataConfiguracionABMusuariosSO/lib/shell.sh
		    source /var/DataConfiguracionABMusuariosSO/lib/UDI.sh
		    source /var/DataConfiguracionABMusuariosSO/lib/userE.sh
		    source /var/DataConfiguracionABMusuariosSO/lib/fechacal.sh
		    source /var/DataConfiguracionABMusuariosSO/sub_shell/agregarUsuario.sh 
		    source /var/DataConfiguracionABMusuariosSO/sub_shell/ModificarUsuario.sh 
		    source /var/DataConfiguracionABMusuariosSO/sub_shell/eliminarUsuario.sh
		    source /var/DataConfiguracionABMusuariosSO/sub_shell/listarUsuarios.sh 
		    source /var/DataConfiguracionABMusuariosSO/sub_shell/agregarGrupo.sh 
		    source /var/DataConfiguracionABMusuariosSO/sub_shell/ModificarGrupo.sh 
		    source /var/DataConfiguracionABMusuariosSO/sub_shell/EliminarGrupo.sh 
		    source /var/DataConfiguracionABMusuariosSO/sub_shell/listarGrupos.sh 
		    source /var/DataConfiguracionABMusuariosSO/sub_shell/Preferencias.sh
		    source /var/DataConfiguracionABMusuariosSO/sub_shell/uninstall.sh
		    source /var/DataConfiguracionABMusuariosSO/sub_shell/cambiarLlaveSsh.sh
		    source /var/DataConfiguracionABMusuariosSO/sub_shell/estadoRedes.sh

		    carpetaBase='/var/DataConfiguracionABMusuariosSO'

		    respuesta="" #El dato pasado por los return solo puede ser numerico, entonces utilizamos una variable externa donde se cargen las salidas, como si fuera un $? pero con mayor capasidad 

		    echo "   _____________________________________________  "
		    echo "   |                                           | "
		    echo "   |                                           | "
		    echo "   |           ABM usuarios y grupos           | "
		    echo "   |                  por Bit                  | "
		    echo "   |                                           | "
		    echo "   |___________________________________________| "	
		    echo "" 
		    # se carga un array con los nombre de las opciones del menu 

		    nombres=('Agregar_usuario' 'Modificar_usuarios' 'Eliminar_usuarios' 'Listar_usuarios' 'Agregar_grupo' 'editar_grupo' 'eliminar_grupo' 'Listar_grupo' 'Editar_preferencias' 'Reinstalar' 'Desinstalar' 'Cambiar_clave_ssh' 'Estado de las redes')
		    # se carga el nombre de los metodos que llaman dichas opciones
		    direcionesSetUp=('agregarUsuario' 'ModificarUsuario' 'eliminarUsuarios' 'listarUsuarios' 'agregarGrupo' 'ModificarGrupo' 'eliminarGrupo' 'MenuListarGrupos' 'Preferencias' 'ConfiguracionDelAmbienteDeTrabajo' 'desinstalar' 'cambiarLlave' 'estadoRedes')
		    menu 'nombres[@]' 'direcionesSetUp[@]' #se llama al metodo menu 
		fi	
	    fi
	fi
    else
	echo "Debe ser root para ejecutar este software"
    fi
else
    echo "Dbe tener instalado Git para utilizar este shell "
fi	
