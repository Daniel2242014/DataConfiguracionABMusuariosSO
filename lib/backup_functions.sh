#!/bin/bash
#VERCION 2.0 - 4/8 SEGUNDA ENTREGA desarrolado por Bit (3°BD 2019)
function crearTotal()
{
    source /var/DataConfiguracionABMusuariosSO/lib/FuncionesBBDD.sh
    if ! [ -d "/var/respaldos" ] #Si la carpeta de los respaldos no existe la creamos 
    then
       mkdir /var/respaldos
       touch /var/respaldos/master
       mkdir /var/respaldos/BBDD #Carpeta con los archivos a respladar
    fi

    NumeroMaster=echo $[$(grep "^T*" /var/respaldos/master| wc -l)+1] #Nos devuleve el numero del respaldo total 
    mkdir /var/respaldos/T$NumeroMaster #Creamos la carpeta de este total

    #Creamos la carpeta BBDD con todos los archivos de la BBDD
    if test -d /opt/IBM/Informix_Software_Bundle/
    then
        persistirBBDD "/var/respaldos/T$NumeroMaster/informix"
        tar cvzf var/respaldos/T$NumeroMaster/T$NumeroMaster.tgz -g var/respaldos/T$NumeroMaster.snar /var/respaldos/T$NumeroMaster/informix var/log/btmp.* var/log/wtmp.* var/log/messages.* /home #Creo el Tar con los datos
        #rm -rf "/var/respaldos/T$NumeroMaster/informix"
    else
        tar cvzf var/respaldos/T$NumeroMaster/T$NumeroMaster.tgz -g var/respaldos/T$NumeroMaster.snar var/log/btmp.* var/log/wtmp.* var/log/messages.* /home #Creo el Tar con los datos
    fi
    sed -i 's/^\(.\+\):ACTUAL:\(.\+\)$/\1:ANTERIOR:\2/' /var/respaldos/master
    echo "T$NumeroMaster:T:$(date):ACTUAL:" >> /var/respaldos/master
}

function totalManual()
{
    crearTotal;
    echo "Total creado: $bname"
    read k
}

function crearDiferencial()
{
    source /var/DataConfiguracionABMusuariosSO/lib/FuncionesBBDD
    if ! [ -d "var/respaldos" ] || [$(grep ":ACTUAL:" /var/respaldos/master| wc -l) -eq 0] #Si la carpeta de los respaldos no existe la creamos 
    then
       echo "Error, debe primero realizar un Backup total"
       return 
    fi

    NumeroMaster=$[$(grep "^T*" /var/respaldos/master| wc -l)+1] #Nos devuleve el numero del respaldo total 
    mkdir /var/respaldos/T$NumeroMaster #Creamos la carpeta de este total

    #Creamos la carpeta BBDD con todos los archivos de la BBDD
    if [-d /opt/IBM]
    then
        persistirBBDD "/var/respaldos/T$NumeroMaster/informix"
        tar cvzf var/respaldos/T$NumeroMaster.tgz -g var/respaldos/T$NumeroMaster.snar /var/respaldos/T$NumeroMaster/informix var/log/btmp.* var/log/wtmp.* var/log/messages.* /home #Creo el Tar con los datos
        rm -rf "/var/respaldos/T$NumeroMaster/informix"
    else
        tar cvzf var/respaldos/T$NumeroMaster.tgz -g var/respaldos/T$NumeroMaster.snar var/log/btmp.* var/log/wtmp.* var/log/messages.* /home #Creo el Tar con los datos
    fi
    sed -i 's/^\(.\+\):ACTUAL:\(.\+\)$/\1:ANTERIOR:\2/' /var/respaldos/master
    echo "T$NumeroMaster:T:$(date):ACTUAL:"

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
    echo $bname > var/respaldos/latest
    cd $curdir
}

function incrementalManual()
{
    crearIncremental
    echo "Incremental creado: $bname"
    read k
}
