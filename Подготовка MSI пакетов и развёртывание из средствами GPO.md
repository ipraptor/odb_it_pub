
# **Подготовка MSI пакетов и развёртывание из средствами GPO**
#MSI #GPO #AD #Windows_server 


Для подготовки MSI пакета нам понадобится установить инструмент
Windows SDK, а точнее приложение "Orca"![](https://i.imgur.com/BtVErHG.png) в модуле "MSI tools".

> Скачать можно с официального сайта Microsoft
https://developer.microsoft.com/ru-ru/windows/downloads/windows-sdk/

При установке снимаем все галочки за исключением "MSI tools"

![](https://i.imgur.com/ytMZqxr.png)

Теперь необходимо пройти внутрь каталога "C:\Program Files (x86)\Windows Kist\10\bin\10.0.22000.0\x86" и запустить там исполняемый файл с именем "Orсa-x86_en-us.msi"

![](https://i.imgur.com/B2ocXRW.png)

После установки в окне программы открываем файл с подлежащим к настройке MSI пакетом.
![](https://i.imgur.com/W6QiGyC.png)





Отправляем запрос на обновление и поиск среди шаблонов LXC контейнеров Debian 10
   
pveam update
pveam available | grep debian-10-standard
   
система получит ответ
> system          debian-10-standard_10.7-1_amd64.tar.gz

Качаем этот шаблон
 pveam download local debian-10-standard_10.7-1_amd64.tar.gz 

Задем поднимаем контейнер из шаблона (лично у меня после развёртывания через консоль, контейнер не запустился поэтому помимо этих строк добавлю инструкцию по GUI)
 pct create 105 local:vztmpl/debian-10-standard_10.7-1_amd64.tar.gz --unprivileged 1 -features nesting=1 --net0 name=eth0,bridge=vmbr0,firewall=1,ip=dhcp,type=veth --storage local-lvm 

В итоге должно получиться нечто подобное...
![](https://i.imgur.com/Qv0qhLp.png)

Возвращаемся в нашу консоль Proxmox

Редактируем параметры контейнера для того чтобы предоставить непревилигированному контейнеру права на создание интерфейсов
 nano /etc/pve/lxc/105.conf 

В случае если используется Proxmox < v7 lxc.cgroup2 необходимо заменить на lxc.cgroup
#  
lxc.cgroup2.devices.allow: c 10:200 rwm
 lxc.mount.entry: /dev/net dev/net none bind,create=dir
   
Нажмите Ctrl-X и ответьте "Y" для сохранения и нажмите Enter.

Чтобы ваш непривилегированный контейнер мог получить доступ к /dev/net/tun с вашего хоста, вам необходимо задать владельца, выполнив:
 chown 100000:100000 /dev/net/tun 
Запускаем контейнер, если ошибок нет должен завестись.
Следующей командой заходим в контейнер
   
pct start 105
pct enter 105
   
Проверяем права пользователя непривилигированного контейнера на директорию
 ls -l /dev/net/tun 
Ответ должен быть примерно таким
> crw-rw-rw- 1 root root 10, 200 Dec 22 12:26 /dev/net/tun
Далее ставим OpenVPN
   
apt update
apt dist-upgrade
apt install openvpn git
   
Для базовой конфигурации можно использовать этот репозиторий https://github.com/Nyr/openvpn-install
   
git clone https://github.com/Nyr/openvpn-install
cd openvpn-install
bash openvpn-install.sh
   
Далее необходимо следовать инструкции мастера, в итоге файл для подключения будет лежать в директории /root/ (например /root/client.ovpn)

Проверяем работоспособность службы
   
systemctl | grep openvpn
ps aux | grep vpn
   
При правильной работе ожидаем такие выводы на каждую команду соответственно.

> openvpn-iptables.service             loaded active exited    openvpn-iptables.service                             
>  openvpn-server@server.service        loaded active running   OpenVPN service for server                           
 system-openvpn\x2dserver.slice       loaded active active    system-openvpn\x2dserver.slice
 
>  nobody     136  0.0  1.3  11780  6844 ?        Ss   14:41   0:00 /usr/sbin/openvpn --status /run/openvpn-server/status-server.log --status-version 2 --suppress-timestamps --config server.conf
