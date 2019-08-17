function estadoServicios()
{
    inp=-1
    while [ $inp -lt 0 ]; do
	serviciosActivados=($(systemctl list-unit-files --state=enabled | tail -n +2 | head -n -2 | cut -d' ' -f1 | grep -vE "target|@"))
	for ((i=0;i<${#serviciosActivados[@]};++i)); do
	    echo $i")" ${serviciosActivados[$i]}
	    state=($(systemctl status ${serviciosActivados[$i]} | grep Active:))
	    #		echo $data;
	    echo -n "Estado: ";
	    echo ${state[1]} # | grep 'Active:' | cut -d' ' -f5
	done
        echo -n "Desea ver los mensajes de algún servicio? [0;${#serviciosActivados[@]}): "
	read inp
	if [ "$inp" == "" ]
	then
	    return
	elif ! echo $inp | grep -E "^[0-9]{1,9}$" > /dev/null;
	then
	    echo "Debe ser un número"
	    inp=-1
	    read ff
	elif [ \( $inp -lt 0 \) -o \( $inp -ge ${#serviciosActivados[@]} \) ]
	then
	    echo "Debe estar en [0;${#serviciosActivados[@]})"
	    inp=-1
	    read ff
	else
	    echo "Viendo mensajes de ${serviciosActivados[$inp]}"
	    journalctl --unit=${serviciosActivados[$inp]}
	    inp=-1
	    read ff
	fi
    done
}
