clear
#Se importan un conjunto de archivos llenos de metodos a utilizar en la ABM
source ./lib/lib_menu.sh
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
source ./lib/sudoUser.sh
source ./lib/allowed.sh
source ./sub_shell/agregarUsuario.sh
source ./sub_shell/ModificarUsuario.sh
source ./sub_shell/eliminarUsuario.sh
source ./sub_shell/listarUsuarios.sh
source ./sub_shell/agregarGrupo.sh
source ./sub_shell/ModificarGrupo.sh
source ./sub_shell/EliminarGrupo.sh
source ./sub_shell/listarGrupos.sh
source ./sub_shell/Preferencias.sh
source ./sub_shell/uninstall.sh
source ./sub_shell/cambiarLlaveSsh.sh
source ./sub_shell/estadoRedes.sh
source ./sub_shell/estadoSockets.sh
source ./sub_shell/listaProcesos.sh
source ./sub_shell/matarProceso.sh
source ./sub_shell/configurarRed.sh
source ./sub_shell/crearLlaveSsh.sh
source ./sub_shell/listarLogs.sh
source ./sub_shell/calendarioBackups.sh
source ./sub_shell/listarBackups.sh
source ./sub_shell/usuariosViaSsh.sh
source ./sub_shell/habilitarSsh.sh
source ./sub_shell/deshabilitarSsh.sh
source ./sub_shell/estadoServicios.sh
source ./sub_shell/smRedes.sh

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

nombres=('Agregar_usuario' 'Modificar_usuarios' 'Eliminar_usuarios' 'Listar_usuarios' 'Agregar_grupo' 'editar_grupo' 'eliminar_grupo' 'Listar_grupo' 'Editar_preferencias' 'Reinstalar' 'Desinstalar' 'Cambiar_clave_ssh' 'Estado_Sockets' 'Lista_Procesos' 'Matar_Proceso' 'Crear_Llave_Ssh' 'Log_Exitoso' 'Log_Fallido' 'Calendario_Backups' 'Listar_Backups' 'Listar_Usuarios_SSH' 'Habilitar_Usuario_SSH' 'Deshabilitar_Usuario_SSH' 'Estado_Servicios' 'Buscar_Servicio' 'Redes')
# se carga el nombre de los metodos que llaman dichas opciones
direcionesSetUp=('agregarUsuario' 'ModificarUsuario' 'eliminarUsuarios' 'listarUsuarios' 'agregarGrupo' 'ModificarGrupo' 'eliminarGrupo' 'MenuListarGrupos' 'Preferencias' 'ConfiguracionDelAmbienteDeTrabajo' 'desinstalar' 'cambiarLlave' 'socketList' 'listaProcesos' 'killProc' 'crearLlaveSsh' 'listarWtmp' 'listarBtmp' 'calendarioBackups' 'listarBackups' 'usuariosViaSsh' 'habilitarSsh' 'deshabilitarSsh' 'estadoServicios' 'buscarServicio' 'smRedes')
menu 'nombres[@]' 'direcionesSetUp[@]' #se llama al metodo menu
