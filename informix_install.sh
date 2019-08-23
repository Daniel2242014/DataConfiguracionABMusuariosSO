#Version 2 SEGUNDA ENTREGA Bit
groupadd informix
useradd -g informix -s /bin/bash -m informix

echo "postgres" | passwd --stdin informix
echo "sqlturbo	1526/tcp" >> /etc/services
echo "sqlexec	1527/tcp" >> /etc/services
echo "sqlexec -ssl	1527/tcp" >> /etc/services
echo "vmInformix" >> /etc/hostname
