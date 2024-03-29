# NAT в Proxmox + проброс порта с виртуальной машины

#Proxmox #NAT #PortForwarding #Linux 

![](https://i.imgur.com/HUjVCxS.png)


Применяется в тех случаях, когда нужно изолировать виртуальные машины в собственной сети, но в тоже время обеспечить им доступ в интернет, а также доступ из внешней сети к некоторым из них (или отдельным сетевым службам). Широко используется в лабораторных сценариях, а также при работе с контейнерами.

PVE-network-configuration-009.pngОбратите внимание, данная конфигурация не может быть изолирована от хоста, так как именно хост предоставляет ей службу трансляции сетевых адресов (NAT) и выступает шлюзом для виртуальных машин. Для настройки такой сети создайте новый сетевой мост без привязки к физическому адаптеру и назначьте ему IP-адрес из произвольной сети, отличной от внешней.

PVE-network-configuration-010.pngВсе изменения сетевой конфигурации требуют перезагрузки узла гипервизора, поэтому, чтобы не перезагружать узел дважды перейдем в консоль сервера и перейдем в директорию /etc/network, в котором будут присутствовать файлы interfaces - с текущей сетевой конфигурацией и interfaces.new - с новой, которая вступит в силу после перезагрузки.

PVE-network-configuration-011.pngОткроем именно interfaces.new и внесем в конец следующие строки:

post-up echo 1 > /proc/sys/net/ipv4/ip_forward
post-up   iptables -t nat -A POSTROUTING -s '192.168.34.0/24' -o ens33 -j MASQUERADE
post-down iptables -t nat -D POSTROUTING -s '192.168.34.0/24' -o ens33 -j MASQUERADE
В качестве сети, в нашем случае 192.168.34.0/24, укажите выбранную вами сеть, а вместо интерфейса ens33 укажите тот сетевой интерфейс, который смотрит во внешнюю сеть с доступом в интернет. Если вы используете сетевую конфигурацию по умолчанию, то это будет не физический адаптер, а первый созданный мост vmbr0, как на скриншоте ниже:

PVE-network-configuration-012.pngПерезагрузим узел и назначим виртуальной машине или контейнеру созданную сеть (vmbr1), также выдадим ей адрес из этой сети, а шлюзом укажем адрес моста.

PVE-network-configuration-013.png

Не забудьте указать доступный адрес DNS-сервера и убедитесь, что виртуальная машина имеет выход в интернет через NAT.




iptables -t nat -A PREROUTING -p tcp --dport 8001 -i vmbr0 -j DNAT --to 10.2.10.106:8001
