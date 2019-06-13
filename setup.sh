#!/bin/bash
# VERCION 1.0 - 25/6 PRIMERA ENTREGA desarrolado por Bit (3°BD 2019)

ConfiguracionDelAmbienteDeTrabajo() #Funcion encarga de la instalacion 
{	
	carpeta="/var" #La carpeta de instalacion sea /var
	ex=0
	if test -d $carpeta/DataConfiguracionABMusuariosSO || test $(echo $PATH | grep "/var/DataConfiguracionABMusuariosSO/"|wc -l) -eq 1 
	then
		echo "El sistema esta instalado, se prosede? (1= si 0=no)" #Si existe preguntamos si desea sobreescribir 
		read d		
		if test $d -eq 1 2> /dev/null #En caso que desde sobre escribir se prosedera con lo sigiente
		then
			desinstalar '1'
			ex=1			
		else
			echo "Operacion cancelada"	
		fi
	else
		ex=1
	fi

	if test $ex -eq 1 #Si desea sobrescribir o la carpeta no existe se prosesdera con la instalacion, de lo contrario se terminara la ejecucion de la funcion 
	then
		ruta=$(pwd) #guardamos en la variable ruta la direcion actual donde se ejecuto el setup de instalacion 
		cd $carpeta #Nos movemos a /var
		git clone https://github.com/Daniel2242014/DataConfiguracionABMusuariosSO
		#Subido en la direcion url que se puede ver en la linea anterior se tiene subido todos los shell script y funciones nesesarias para el correcto funcionamiento de la ABM. De esta forma el usuario no debera tener todos los archivos, solamente el shell setup para la instalacion

		cd DataConfiguracionABMusuariosSO/ #entramos dentro de la carpeta de instalacion
		
		echo "PATH=$PATH:/var/DataConfiguracionABMusuariosSO/" >> /etc/profile
		echo "export PATH" >> /etc/profile
		PATH="$PATH:/var/DataConfiguracionABMusuariosSO/"
		export PATH
		mkdir Backup Temp #Creamos la carpeta BackUp y Temp 
		cd $ruta 
		if test $(grep -e "^Operario:" /etc/passwd| wc -l) -eq 0 # si el usuario operario existe 
 		then
			useradd Operario #Este usuario se crea para el acceso de los operarios al sistema
			echo "ope_bit2019" | passwd --stdin Operario > /dev/null #Se le asigna la contraseña al operario
		fi

		if test $(grep -e "^Trasportista:" /etc/passwd| wc -l) -eq 0 #si el usuario trasportisa existe 
		then
			useradd Trasportista #Este usuario se crea para el acceso de los trasportista al sistema
			echo "tras_bit2019" | passwd --stdin Trasportista > /dev/null #Se le asigna la contraseña al trasportista 
		fi	

		if test $(grep -e "^Administrador:" /etc/passwd| wc -l) -eq 0
		then
			useradd Administrador #Este usuario se crea para el acceso de los administradores al sistema 
			echo "admin_bit2019" | passwd --stdin Administrador > /dev/null #Se le asigna la contraseña al administrador
		fi
		chmod 700 /var/DataConfiguracionABMusuariosSO 	
		echo "Proseso terminado con exito, ejecute setup.sh desde la consola"
	fi

}

desinstalar()
{
		#Subido en la direcion url que se puede ver en la linea anterior se tiene subido todos los shell script y funciones nesesarias para el correcto funcionamiento de la ABM. De esta forma el usuario no debera tener todos los archivos, solamente el shell setup para la instalacion
 		if test -d var/DataConfiguracionABMusuariosSO/
		then
			rm -f /var/DataConfiguracionABMusuariosSO/ #entramos dentro de la carpeta de instalacion
		fi		
		grep -ve "PATH=\|export PATH" /etc/profile > /etc/profile
		PATH=$(echo $PATH | sed -e 's/\/var\/DataConfiguracionABMusuariosSO\/://g')
		export PATH
		if test $(grep -e "^Operario:" /etc/passwd| wc -l) -eq 1 # si el usuario operario existe 
 		then
			userdel Operario 
		fi

		if test $(grep -e "^Trasportista:" /etc/passwd| wc -l) -eq 1 #si el usuario trasportisa existe 
		then
			userdel Trasportista 
		fi	

		if test $(grep -e "^Administrador:" /etc/passwd| wc -l) -eq 1
		then
			userdel Administrador 
		fi
		echo "Proseso terminado con exito"	
		read f	
		if test -z $1
		then 
			exit
		fi	
}


if test $(w |tail -$[$(w | wc -l)-2] | grep "sh setup" | wc -l) -eq 0
then
	
	if test $USER = "root" 
	then
		echo $PATH | grep "/var/DataConfiguracionABMusuariosSO/"|wc -l
        echo $PATH
	read f
		if test $(echo $PATH | grep "/var/DataConfiguracionABMusuariosSO/"|wc -l) -eq 1  #Si existe este archivo, significa que el sistema fue instalado, de todas formas se puede volver a reinstalar el software 
		then
			clear
			#Se importan un conjunto de archivos llenos de metodos a utilizar en la ABM
			source ./lib/lib_menu.sh
			source ./lib/lib_error.sh
			source ./lib/DT.sh
			source ./lib/expiracionUsuario.sh
			source ./lib/GP.sh
			source ./lib/GS.sh
			source ./lib/NDiasHasta.sh
			source ./lib/pass.sh
			source ./lib/shell.sh
			source ./lib/UDI.sh
			source ./lib/userE.sh
			source ./lib/fechacal.sh
			source ./sub_shell/agregarUsuario.sh 
			source ./sub_shell/ModificarUsuario.sh 
			source ./sub_shell/eliminarUsuario.sh
			source ./sub_shell/listarUsuarios.sh 
			source ./sub_shell/agregarGrupo.sh 
			source ./sub_shell/ModificarGrupo.sh 
			source ./sub_shell/EliminarGrupo.sh 
			source ./sub_shell/listarGrupos.sh 
			source ./sub_shell/Preferencias.sh 


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
			nombres=('Agregar_usuario' 'Modificar_usuarios' 'Eliminar_usuarios' 'Listar_usuarios' 'Agregar_grupo' 'editar_grupo' 'eliminar_grupo' 'Listar_grupo' 'Editar_preferencias' 'Reinstalar' 'Desinstalar')
			# se carga el nombre de los metodos que llaman dichas opciones 
			direcionesSetUp=('agregarUsuario' 'ModificarUsuario' 'eliminarUsuarios' 'listarUsuarios' 'agregarGrupo' 'ModificarGrupo' 'eliminarGrupo' 'MenuListarGrupos' 'Preferencias' 'desinstalar'  'ConfiguracionDelAmbienteDeTrabajo')

			menu 'nombres[@]' 'direcionesSetUp[@]' #se llama al metodo menu 

		else
			echo "   _____________________________________________  "
			echo "   |                                           | "
			echo "   |                                           | "
			echo "   |           ABM usuarios y grupos           | "
			echo "   |                  por Bit                  | "
			echo "   |                                           | "
			echo "   |___________________________________________| "
			echo "" 
		
			echo "debe instalar el softare para utilizarlo" 
			echo "Desea comenzar el proseso de instalacion? (1= si 0=no)"
			read de		
			if test $de -eq 1 2> /dev/null #Comprueba que el dato ingresado sea 1
			then
				ConfiguracionDelAmbienteDeTrabajo #se prosesde con la instalacion del sistema 
			fi	
		fi
	else
		echo "Debe ser root para ejecutar este software"
	fi
else
	
	echo "No puede ejecuar este shell script con el comando 'sh' use source o el nombre del archivo setup.sh"
fi

