#!/bin/bash
#Version 2 SEGUNDA ENTREGA Bit
function crearTotal()
{
    curdir=$(pwd)
    cd /
<<<<<<< HEAD
    if ! [ -d "var/backups" ]
    then
        mkdir var/backups
    fi
    bname=total_$(date +%d-%m-%Y)
    tar cvzf var/backups/$bname.tgz -g var/backups/$bname.snar opt/informix var/log/btmp.* var/log/wtmp.* var/log/messages.* home
    if ! [ -f "var/backups/backups.csv" ]
    then
	echo NOMBRE,DEPENDENCIA > var/backups/backups.csv
    fi
    echo $bname,null >> var/backups/backups.csv
    echo $bname > var/backups/last_total
    echo $bname > var/backups/latest
=======
    if ! [ -d "var/respaldos" ]
    then
        mkdir var/respaldos
    fi
    bname=total_$(date +%d-%m-%Y)
    tar cvzf var/respaldos/$bname.tgz -g var/respaldos/$bname.snar opt/informix var/log/btmp.* var/log/wtmp.* var/log/messages.* home
    if ! [ -f "var/respaldos/respaldos.csv" ]
    then
	echo NOMBRE,DEPENDENCIA > var/respaldos/respaldos.csv
    fi
    echo $bname,null >> var/respaldos/respaldos.csv
    echo $bname > var/respaldos/last_total
    echo $bname > var/respaldos/latest
>>>>>>> 2e625d6c86bb7e581d007135e2a1164d5c636b1a
    cd $curdir
}

function totalManual()
{
    crearTotal;
    echo "Total creado: $bname"
    read k
}

function crearDiferencial()
{
    curdir=$(pwd)
    cd /
<<<<<<< HEAD
    if ! [ -d "var/backups" ]
    then
        mkdir var/backups
    fi
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
=======
    if ! [ -d "var/respaldos" ]
    then
        mkdir var/respaldos
    fi
    last_total=$(cat var/respaldos/last_total)
    last_date=$(echo $last_total | cut -d_ -f2)
    bname=diferencial_$(date +%d-%m-%Y)
    cp var/respaldos/$last_total.snar var/respaldos/$bname.snar
    tar cvzf var/respaldos/$bname.tgz -g var/respaldos/$bname.snar opt/informix var/log/btmp.* var/log/wtmp.* var/log/messages.*
    if ! [ -f "var/respaldos/respaldos.csv" ]
    then
	echo NOMBRE,DEPENDENCIA > var/respaldos/respaldos.csv
    fi
    echo $bname,$last_total >> var/respaldos/respaldos.csv
    echo $bname > var/respaldos/latest
>>>>>>> 2e625d6c86bb7e581d007135e2a1164d5c636b1a
    cd $curdir
}

function diferencialManual()
{
    crearDiferencial;
    echo "Diferencial creado: $bname"
    read k
}

function crearIncremental()
{
    curdir=$(pwd)
    cd /
<<<<<<< HEAD
    if ! [ -d "var/backups" ]
    then
        mkdir var/backups
    fi
    last=$(cat var/backups/latest)
    echo Based on $last
    bname=incremental_$(date +%d-%m-%Y)
    echo 'Copying last.snar ($last.snar) to $bname.snar'
    cp var/backups/$last.snar var/backups/$bname.snar
    stat var/backups/$last.snar
    stat var/backups/$bname.snar
    read k
    tar cvzf var/backups/$bname.tgz -g var/backups/$bname.snar opt/informix var/log/btmp.* var/log/wtmp.* var/log/messages.*
    if ! [ -f "var/backups/backups.csv" ]
    then
	echo NOMBRE,DEPENDENCIA > var/backups/backups.csv
    fi
    echo $bname,$last >> var/backups/backups.csv
    echo $bname >> var/backups/latest
=======
    if ! [ -d "var/respaldos" ]
    then
        mkdir var/respaldos
    fi
    last=$(cat var/respaldos/latest)
    echo Based on $last
    bname=incremental_$(date +%d-%m-%Y_%H:%M)
    echo 'Copying last.snar ($last.snar) to $bname.snar'
    cp var/respaldos/$last.snar var/respaldos/$bname.snar
    stat var/respaldos/$last.snar
    stat var/respaldos/$bname.snar
    read k
    tar cvzf var/respaldos/$bname.tgz -g var/respaldos/$bname.snar opt/informix var/log/btmp.* var/log/wtmp.* var/log/messages.*
    if ! [ -f "var/respaldos/respaldos.csv" ]
    then
	echo NOMBRE,DEPENDENCIA > var/respaldos/respaldos.csv
    fi
    echo $bname,$last >> var/respaldos/respaldos.csv
    echo $bname >> var/respaldos/latest
>>>>>>> 2e625d6c86bb7e581d007135e2a1164d5c636b1a
    cd $curdir
}

function incrementalManual()
{
    crearIncremental
    echo "Incremental creado: $bname"
    read k
}
