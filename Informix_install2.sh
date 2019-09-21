#!/bin/bash
#VERCION 2.0 - 4/8 SEGUNDA ENTREGA desarrolado por Bit (3°BD 2019)
source /etc/profile.d/zz_configInformix.sh
su informix -c "source /etc/profile.d/zz_configInformix.sh; oninit -ivy; onmode -vky; oninit -vy"
cp /var/DataConfiguracionABMusuariosSO/informix.service /etc/systemd/system/
cp /var/DataConfiguracionABMusuariosSO/sysconfig.informix /etc/sysconfig/sysconfig.informix
systemctl enable informix
rm -f /var/DataConfiguracionABMusuariosSO/I_Inxo
echo "Informix instalado con exito"
