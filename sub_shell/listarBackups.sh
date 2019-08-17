#!/bin/bash

function listarBackups()
{
    bks=$(ls -t /var/backups/*.tgz | cut -d"/" -f4 | cut -d. -f1)
    for i in $bks; do
	tipo=$(echo $bks | cut -d_ -f1)
	echo ${tipo^}: $(echo $bks | cut -d_ -f2)
    done
    read ff
}
