#!/bin/bash
#Version 2 SEGUNDA ENTREGA Bit
function crearTotal()
{
    curdir=$(pwd)
    cd /
    bname=total_$(date +%d-%m-%Y)
    tar cvzf var/backups/$bname.tgz -g var/backups/$bname.snar opt/informix var/log/btmp.* var/log/wtmp.* var/log/messages.* home
    if ! [ -f "var/backups/backups.csv" ]
    then
	echo NOMBRE,DEPENDENCIA > var/backups/backups.csv
    fi
    echo $bname,null >> var/backups/backups.csv
    echo $bname > var/backups/last_total
    echo $bname > var/backups/latest
    cd $curdir
}

function crearDiferencial()
{
    curdir=$(pwd)
    cd /
    last_total=$(cat var/backups/last_total)
    last_date=$(echo $last_total | cut -d_ -f2)
    bname=diferencial_$(date +%d-%m-%Y)
    cp var/backups/$last_total.snar var/backups/$bname.snar
    tar cvzf var/backups/$bname.tgz -g var/backups/$bname.snar opt/informix var/log/btmp.* var/log/wtmp.* var/log/messages.*
    if ! [ -f "var/backups/backups.csv" ]
    then
	echo NOMBRE,DEPENDENCIA > var/backups/backups.csv
    fi
    echo $bname,$last_total >> var/backups/backups.csv
    echo $bname > var/backups/latest
    cd $curdir
}

function crearIncremental()
{
    curdir=$(pwd)
    cd /
    last=$(cat var/backups/latest)
    last_date=$(echo $last | cut -d_ -f2)
    bname=incremental_$(date +%d-%m-%Y)
    cp var/backups/$last.snar var/backups/$bname.snar
    tar cvzf var/backups/$bname.tgz -g var/backups/$bname.snar opt/informix var/log/btmp.* var/log/wtmp.* var/log/messages.*
    if ! [ -f "var/backups/backups.csv" ]
    then
	echo NOMBRE,DEPENDENCIA > var/backups/backups.csv
    fi
    echo $bname,$last >> var/backups/backups.csv
    echo $bname >> var/backups/latest
    cd $curdir
}
