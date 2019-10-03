#!/bin/bash
#VERCION 2.0 - 4/8 SEGUNDA ENTREGA desarrolado por Bit (3°BD 2019)
source /etc/profile.d/zz_configInformix.sh
su informix -c "source /etc/profile;oninit -ivy;onmode -vky;oninit -vy"
cp /var/DataConfiguracionABMusuariosSO/informix.service /etc/systemd/system/
cp /var/DataConfiguracionABMusuariosSO/sysconfig.informix /etc/sysconfig/sysconfig.informix
#systemctl start informix
systemctl enable informix
echo "Modificado firewall"
# puede entrar a la red todo lo que venga por Informix (9088)
		iptables -A INPUT -p tcp --destination-port 9088 -j ACCEPT
		iptables -A OUTPUT -p tcp --destination-port 9088 -j ACCEPT
		iptables -A INPUT -p udp --destination-port 9088 -j ACCEPT
		iptables -A OUTPUT -p udp --destination-port 9088 -j ACCEPT
source /var/DataConfiguracionABMusuariosSO/lib/re_sysmaster.sh
sysmaster '0'
rm -f /var/DataConfiguracionABMusuariosSO/I_Inxo
echo "Informix instalado con exito"
