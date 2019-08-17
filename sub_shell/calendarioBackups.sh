function calendarioBackups()
{
    mes=-1
    while [ $mes -lt 0 ];
    do
	echo -n "Inserte mes [1-12] del que desea ver el calendario de Backups: "
	read mes
	if [ $(echo $mes | grep -E "^1{0,1}[0-9]{1}$" | wc -l) -eq 0 ]
	then
	    mes=-1
	elif [ \( $mes -gt 12 \) -o \( $mes -lt 1 \) ]
	then
	    mes=-1
	fi
	if [ $mes -lt 0 ]
	then
	    echo "Mes incorrecto. Debe estar entre 1 y 12 ambos inclusive"
	fi
    done
    diasDelMes=$(date -d "$mes/1 + 1 month - 1 day" +%d)
    pDMes=$[$(date -d "$mes/1" +%u)-1]
    echo "L M M J V S D"
    for ((i=1;i<=$pDMes;++i)); do
	echo -n "  "
    done
    for ((i=1;i<=$diasDelMes;++i)); do
	tipoBackup=""
	ds_sa=$(date -d "$mes/$i" +%u-%V)
	diaSemana=$(echo $ds_sa | cut -d"-" -f1)
	semana_anio=$(echo $ds_sa | cut -d"-" -f2)
	if [ $diaSemana -eq 7 ]
	then
	    if [ $[$semana_anio%2] -eq 1 ]
	    then
		echo "T"
	    else
		echo "D"
	    fi
	else
	    echo -n "I "
	fi
    done
    echo " "
    echo "Clave: I -> Incremental, T -> Total, D -> Diferencial (con último total)"
    read ff
}
