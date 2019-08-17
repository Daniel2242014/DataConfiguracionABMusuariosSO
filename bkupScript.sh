#!/bin/bash

function crearTotal()
{
    curdir=$(pwd)
    cd /
    bname=total_$(date +%d-%m-%Y)
    tar cvzf var/backups/$bname.tgz -g var/backups/$bname.snar opt/informix var/log home
    cp var/backups/$bname.snar var/backups/latest.snar
    cd $curdir
}

function crearDiferencial()
{
    curdir=$(pwd)
    cd /
    last_total=$(ls -t var/backups/total*.tgz | head -1 | cut -d. -f1)
    last_date=$(echo $last_total | cut -d_ -f2)
    bname=diferencial_$(date +%d-%m-%Y)_based_on_$(last_date)
    cp var/backups/$last_total.snar var/backups/$bname.snar
    tar cvzf var/backups/$bname.tgz -g var/backups/$bname.snar opt/informix var/log home
    cp var/backups/$bname.snar var/backups/latest.snar
    cd $curdir
}

function crearIncremental()
{
    curdir=$(pwd)
    cd /
    last=$(ls -t var/backups/*.snar | grep -vE "latest" | head -1 | cut -d. -f1)
    last_date=$(echo $last | cut -d_ -f2)
    bname=incremental_$(date +%d-%m-%Y)_based_on_$(last_date)
    cp var/backups/$last.snar var/backups/$bname.snar
    tar cvzf var/backups/$bname.tgz -g var/backups/$bname.snar opt/informix var/log
    cp var/backups/$bname.snar var/backups/latest.snar
    cd $curdir
}

if [ \( ! -d /var/backups \) -o \( $(ls /var/backups/ | grep snar | wc -l) -eq 0 \) ]
then
    mkdir -p /var/backups
    crearTotal
else
    if [ $(date +%u) -eq 7 ]
    then
	if [ $[$(date +%V)%2] -eq 1 ]
	then
	    if [ $(date +%d) -lt 8 ]
	    then
		rm -f /var/backups/incremental_* 2>/dev/null
	    fi
	    crearTotal
	else
	    crearDiferencial
	fi
    else
	crearIncremental
    fi
fi
echo "Backup creado: $bname"
