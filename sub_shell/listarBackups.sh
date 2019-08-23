#!/bin/bash
#version 2 segunda entrega bit
function listarBackups()
{
    bks=($(ls -t /var/backups/*.tgz | cut -d"/" -f4 | cut -d. -f1))
    for i in ${!bks[@]}; do
	tipo=$(echo ${bks[$i]} | cut -d_ -f1)
	echo $i: ${tipo^}: ${bks[$i]}
    done
    echo -n "Desea restaurar algún backup? [0-${#bks[@]}): "
    read ff
    if [ \( "$ff" = "" \) -o \( "$ff" -lt 0 \) -o \( "$ff" -ge ${#bks[@]} \) ]
    then
	return
    fi
    cnode = ${bks[$ff]}
    deptree=("$cnode")
    while [ $(grep "$cnode" /var/backups/backups.csv | cut -d, -f2) != "null" ]; do
	cnode=$(grep "$cnode" /var/backups/backups.csv | cut -d, -f2)
	deptree[@]="$cnode"
    done
    echo -n "Para restaurar ese backup, debe restaurar la cadena: ${deptree[@]} ¿Desea continuar? (y/N): "
    read ff
    if [ "$ff" = "y" ];
    then
	for ((i=$[${#deptree[@]}-1]; i>=0; i--)); do
	    echo ${deptree[$i]}
	done
    fi
}
