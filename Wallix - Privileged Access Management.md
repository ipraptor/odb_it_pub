# Wallix - Privileged Access Management
#PAM #Wallix 

# ==Основные данные==

## Логин пароль по умолчанию
| Логин | Пароль     |
| -------- | --------  |
| wabadmin | !QAZ2wsx |
## Сетевые порты
| Назначение | Порт     |
| -------- | --------  |
| SSH      | 2242    |
| Веб      | 443     |
## Суперпользователь
   bash=
super
<вводим пароль>
sudo -i
<вводим пароль>
   

# ==Как работает СКПДУ?==

## Архитектурно
Wallix ставится в разрыв между системными администраторами и защищаемыми устройствами и работает на L7 уровне модели OSI.
![](https://i.imgur.com/Tv14qN3.png)

Настройки представляют собой бинарные (истина-ложь\\можно-нельзя) сопоставления между двумя типами групп: группы учетных записей на самом Wallix (можно заменить на учетные записи, импортированные из AD) и группы пар Сервер + конечная учетная запись.

Число таких сопоставлений, как и самих групп, не ограничено и на их основе выстраивается матрица доступа кому и куда можно подключаться.
  
Wallix хранит записи rdp в виде видео-роликов (в файловом виде), которые можно прогнать через встроенный распознаватель текста (ocr), после чего искать по заголовкам.

## Со стороны клиента
1. Вы аутентифицируетесь посредством веб-интерфейса на сервере Wallix.
2. Там видите доступные вам сервисы и устройства для удалённого подключения, SSH, RDP, Веб-приложения, пробрасываемые порты и т д
3. Доступ может быть предоставлен посредством туннелирования изображения с целевого сервера прямо в окно браузера через https
4. Если доступ перманентный подключаетесь в любое время, если доступ по запросу выбираете дату и время подключения и отправляете запрос администратору безопасности.
5. После одобрения (если оно необходимо) осуществляете подключение в рамках ваших полномочий.
6. В случае исполнения неразрешенных программ\процессов или доступа к не разрешенным IPадресам\портам\директориям, вас может предупредить что данные действия запрещены либо система разорвёт текущую сессию.
7. При выполнении определённых действий, таких как повышение полномочий, администратору может прийти уведомление о том что вы получили повышенные привелегии
8. Ваша сессия логируется, а все выполняемые действия фиксируются.

   


   

# Список возможностей продукта

* Получение доступа к инфраструктуре с внешним паролем, без знания пароля от внутренней среды
* Предоставление удалённого доступа посредством SSL VPN
* Предоставление доступа к Web приложениям в режиме "киоска" с фиксированием всех сеансов и историей подключений
* Предоставление туннелирования любого порта с целевого сервера
* Предоставление безопасного доступа к PLC оборудованию (IoT оборудование, modbus трафик и т д)
* Предоставление безопасного доступа к инфраструктуре с разграничениями привилегий
* Контроль действий администраторов
* Блокировка незарегистрированных действий администраторов на целевых серверах
* Выполнять оповещения при определённых действиях администраторов на целевых серверах
* Создать для администраторов среду для создания запроса на подключение к ресурсу и предоставить контроллирующим администраторам безопасности разрешить или отклонить любой подобный запрос
* Cоздать запрос для запланированных работ. Который будет разрешать администратор безопасности.
* Интеграция вышеописанного процесса с ITSM системами 
* Заданный логин при авторизации можно трансформировать из того что вводится в Wallix в тот что будет в системе, это называется операция преобразования.
* AD-Bridging - аутентификация пользователей в Linux под УЗ из AD
* Выполнять кастомизацию логотипа страницы аунтентификации в системе Wallix PAM (встраивать свой логотип)
* Создавать пароль локального администратора для конечного сервера и менять его ежедневно генерируя новый исходя из начально заданного пароля и будущей даты





# СКДПУ НТ
Для функционала СКДПУ НТ требуется один виртуальный сервер. СКДПУ НТ собирает данные для анализа со всех серверов СКДПУ по протоколу Syslog. На основе полученных данных СКДПУ НТ строит цифровые профили пользователей. 

![](https://hackmd.io/_uploads/rJtDMidS3.png)

   


   

# ==Некоторые настройки==

## Настройка доступа к ресурсу по SSH

spoiler
* Добавляем группу ![](https://i.imgur.com/EQ85kS8.png)
* Добавляем пользователя для созданной группы ![](https://i.imgur.com/BbPf6hU.png)
* Задаём имя пользователя, электронную почту, профиль, группу, метод аутентификации (в нашем случае локальный пароль) и задаём пароль. ![](https://i.imgur.com/gMzchUU.png)
* Создаём целевое устройство, задаём для него имя в Wallix и ip адрес\FQDN имя. Обязательно применяем настройки ![](https://i.imgur.com/0T1rh0V.png)
* Создаём службу которая будет доступна для доступа на данном устройстве, заполняем все необходимые поля ![](https://i.imgur.com/m25TNEL.png)
* Создаём локальный аккаунт. Необходимо указать имя учётной записи, а так-же логин для входа на целевое устройство. Нажимаем "применить и продолжить" ![](https://i.imgur.com/2K2lhTU.png) ![](https://i.imgur.com/p70VaNP.png)
* Задаём пароль от учётной записи с доступом по SSH![](https://i.imgur.com/1yFSsir.png)
    > [!Note]
    :information_source: Пароль на данном этапе должен     отличаться от того что установлен на основном аккаунте     пользователя
    
* Связываем группу с системой ![](https://i.imgur.com/SiaJ25l.png) ![](https://i.imgur.com/kgV7oR0.png)
* Предоставляем права на управление сеансами цели. Для этого выбираем созданную систему, предоставляемый сервис и УЗ созданную ранее![](https://i.imgur.com/JpwcwuF.png)![](https://i.imgur.com/conO08O.png)![](https://i.imgur.com/2uWvkzv.png)
* Добавляем авторизацию чтобы предоставить локальному пользователю Wallix права на конечном устройстве. Для этого указываем созданную группу пользователей, группу целевого устройства, добавляем имя авторизационного правила, разрешаем протоколы для создания сеанса и включаем запись созданной сесси![](https://i.imgur.com/B7TnHef.png)![](https://i.imgur.com/idEICGx.png)![](https://i.imgur.com/RzPX5MP.png)

    success
    :accept: Готово!
    
Теперь при логоне под созданным пользователем мы увидем доступные для подключения ресурсы 

![](https://i.imgur.com/CfzlXdp.png)
![](https://i.imgur.com/IT9Rxdk.png)
![](https://i.imgur.com/rJENIXm.png)


## Поднятие тревоги и блокировка сеанса при авторизованных действиях shell

spoiler

> :information_source: Есть два варианта настройки защиты сеанса
> * Для группы **целей (целевых устройств)**
> * Для группы **пользователей (клиентов)**


![](https://i.imgur.com/SCUH7kj.png)
![](https://i.imgur.com/uCZj6Vo.png)
![](https://i.imgur.com/jiAgBje.png)

Теперь пользователь может видеть директорию ~/DONOTOPEN но не может получить к ней доступ
![](https://i.imgur.com/ZpJvmyD.png)

А когда пользователь повысит свои привелегии администратор получит уведомление по электронной почте

При повторной попытке обратиться к директории ~/DONOTOPEN ssh сеанс будет автоматически завершён.
![](https://i.imgur.com/VdzXsmg.png)


## Пример правила блокировки дочернего процесса и доступа к определённым адресам по выставленным портам
spoiler
![](https://i.imgur.com/y9XYl26.png)

   


   

# Лицензирование
spoiler
![](https://i.imgur.com/nkxsSDA.png)

Лицензия для Access Manager
![](https://i.imgur.com/l29hK67.png)

   


   

# Кластер
spoiler
    
   > [!Warning]
   :warning: **ВАЖНО** :warning:
   Wallix не рекомендует использовать кластер с виртуальными машинами, вместо    этого можно воспользоваться репликациями.
   
    
   > [!Warning]
        Для bare-metal исполнения Wallix\СКДПУ ноды соединяются кросовым     кабелем и в консоли из под root прописывается команда
       #  bash=
        WABHASetup
       #  
        **Шаги настройки кластера СКДПУ:**

- Подключитесь к веб-интерфейсу первого узла кластера и перейдите в раздел «Система» → «Сеть». Настройте интерфейс eth1, задав ему IP-адрес и маску сети.
- Разверните второй узел кластера СКДПУ по инструкции «Быстрая настройка». Настройте сеть, DNS, NTP согласно в инструкции. Версии узлов кластера должны быть одинаковы.
- В веб-интерфейсе второго узла перейдите в раздел «Система» → «Сеть» и выполните настройки:
- укажите имя хоста (hostname), отличное от имени хоста первого узла;
- настройте интерфейс eth1, задав ему IP-адрес и маску сети;
- убедитесь, что в маршрутах указан шлюз по умолчанию, если его нет – добавьте.

    
success


# Репликация
    > [!Note]
    :information_source: Для **репликации** используется ещё одна машина на которой крутится скрипт репликации.
    

Заполняем поля адреса и ключ, под блоком src поднимается машина откуда будут браться настройки, а dst куда.
   #  bash=
    vim /etc/skdpu/WABReplic.ini
   #  
    Через крон можно задать копирования настроек
   #  bash=
    crontab -e
   #  
    ![](https://i.imgur.com/UXhKNe0.png)

    При это будет запущен скрипт /opt/skdpu/venv/bin/WABReplic.py
    который в процессе отработки переносит настройки на вторую ноду.


   



   

# Сброс пароля веб интерфейса
   bash=
/opt/wab/bin/WABRestoreDefaultAdmin
   

   



   

# Дополнительный функционал Wallix

## Wallix Best Safe PEDM

Блокирует запуск недекларируемого функицонала высокопривелигированного персонала.

Wallix останавливает вредоносные программы не на основе сигнатур, а проводя поведенческий анализ

## Wallix Access Manager
Позволяет получить доступ администраторам к критически важной инфраструктуре за пределами локальной сети.

Поддерживает MFA и аутентификацию по пользователю AD.
Можно осуществлять предоставление доступа по SSL VPN.



success

---



# ИМПОРТОЗАМЕЩЕНИЕ - СКДПУ (система контроля доступа поставщиков услуг)

## Те же гуси только в профиль
По функционалу тоже самое с небольшими изминениями во внешнем виде
![](https://i.imgur.com/0bftKTT.png)





# Вопросы для самопроверки
- какие права можно выдавать пользователю
- как дебажить, какие логи есть
- резервирование, обновление, миграция системы
- Какие есть способы подключения, режимы работы валикса
- как собрать кластер
- API
- авторизация через LDAP
- интергация с системой мониторинга

spoiler **Ответы на вопросы**
- **какие права можно выдавать пользователю?**
    - ![](https://i.imgur.com/GqeDQ7q.png)
    - **РОЛИ:**
    - approver - только управлять разрешениями
    - auditor - только просматривать сесиии
    - operation_administrator - Может всё кроме доступа к резервным копиям, настройкам системы, аудит сессий и системы
    - system_administrator - Наоборот может только в резервные копии, настройки системы, аудит сессий и системы
    - user - имеет доступ к целевым УЗ
    - WAB_administrator - имеет полный доступ
- **как дебажить, какие логи есть?**
    - Юзер не может авторизоваться, смотрим с какой учётки логинился, смотрим ошибку в "аудит\истории авторизации" и исправляем.
    - syslog, отчёт по запуску (который скорее dmesg), отладочные данные из раздела "Система\Статус", там есть логи ядра, апачи ошибки и т д
    - История авторизаций, история разрешений, график со статистикой соединений, история соединений, история по учётной записи, текущие соединения
- **резервирование**
    - Выгружаются в разделе "Система\Резервные копии" после ввода ключа из 16 символов. Без этого ключа с данного файла не восстановиться. Бэкап представляет собой зашифрованные конфиги.
    - CLI - «config-backup.py» и «config-restore.py»
    - Бэкап автоматичен. По умолчанию ежедневно в 18:50 в каталог /var/wab/backups
- **обновление**
    - Обновления выгружаются вендором и устанавливаются вручную, в процессе обновления будет система может быть недоступна. Вендор рекомендует выполнять обновление путем переноса бэкапа и записей сессий на новую инсталляцию СКДПУ
- **миграция системы** 
    - Миграцию можно выполнить с помощью панели "импорт\экспорт" в ней можно экспортировать в CSV через него выгружаем настраиваемые списки, так же на панели система резервное копирование делаем backup конфигураций, затем на целевом сервере импортируем из CSV на сервер базу
- **Какие есть способы подключения, режимы работы валикса**
    - Два компонента СКДПУ и СКДПУ НТ (поведенческий анализ)
    - RDP, VNC, SSH, RLOGIN, TELNET, SSH, RAWTCPIP (RS-232)
    - Режим Бастион (прокси) и режим маршрутизатор
- **как собрать кластер**
    - На хардверных нодах кластер собирается путём соединения нод кроссовым кабелем и вводом команды WABHASetup
    - Отлючение\включение кластера на ноде /etc/init.d/wabha <stop\start>
- **Репликация**
    - вносим в /var/wab/etc/wabrestapi.conf две строчки 1) *credential_recovery = True* 2) *user_password_hash = True*
    -#  WABConsole -u admin –c "add_api_key –n <hostname>"   
    - скрипт который запускается находится тут /usr/sbin/WABReplic
- **API**
    - Для API создаётся ключ который можно увидеть только при создании.
- **авторизация через LDAP**
    - в AD создаём 3 группы WAB users, WAB auditors, WAB admins.
    - В веб интерфейсе Wallix создаём 3 локальные группы соответственно тем что создали на AD.
    - «Конфигурация» → «Внешние авторизации», заполняем обязательные поля ![](https://i.imgur.com/o97ErJy.png)
    - «Конфигурация» → «Домены LDAP/AD», заполняем обязательные поля, в конце соотносим группы AD с локальными группами Wallix ![](https://i.imgur.com/vyxoHF4.png)

- **интергация с системой мониторинга**
    - "Система" → "Интеграция с SIEM", по сути просто отправляем syslog в IP SIEM




   


   



   
1  apt-get install ssh
    2  systemctl start ssh
    3  systemctl enable ssh
    4  vim.tiny /etc/network/interfaces
    5  reboot
    6  vim.tiny /etc/apt/sources.list
    7  reboot
    8  vim.tiny /etc/network/interfaces
    9  /etc/init.d/networking restart
   10  mount /dev/sr0 /mnt/smolensk && mount /dev/sr1 /mnt/smolensk-devel
   11  cd  /home/wabadmin/
   12  tar -xvzf ./cd-image.tar.gz
   13  cd ./cd-image/
   14  ./autostart.sh
   15  LANG=en_US.utf8 apt-get install -o DPkg::options::="--force-confold" skdpu
   16  cd
   17  mc
   18  reboot
   19  ip a
   20  vi /etc/network/interfaces
   21  vi /etc/network/interfaces
   22  ifconfig eth0 172.10.10.50 netmask 255.255.255.0 up
   23  ifconfig eth1 172.10.10.50 netmask 255.255.255.0 up
   24  reboot now
   25  shutdown -r
   26  exit
   27  ip a
   28  ping 192.168.1.1
   29  ping 192.168.1.170
   30  ping -a 192.168.1.170
   31  vi /etc/network/interfaces
   32  ping 172.10.10.2
   33  ping 172.10.10.1
   34  ping 172.10.10.2
   35  ping 172.10.10.2
   36  ping 172.10.10.3
   37  /opt/wab/bin/WABRestoreDefaultAdmin
   38  iptables --list
   39  iptables --list |grep ACCEPT
   40  iptables --list |grep ACCEPT | grep https
   41  netstat =putenl
   42  netstat -putenl
   43  iptables --list |grep ACCEPT | grep https
   44  iptables --list |grep ACCEPT | grep http
   45  iptables --list |grep nat
   46  iptables --list |grep NAT
   47  iptables --list
   48  iptables -A INPUT -p tcp --dport 443 -j ACCEPT
   49  iptables --save
   50  iptables --
   51  iptables-save
   52  iptables --list |grep 443
   53  iptables --list | grep 443
   54  iptables --list
   55  iptables --list-all
   56  iptables-stop
   57  service iptables stop
   58  sudo service iptables stop
   59  systemctl iptables stop
   60  systemctl stop iptables
   61  systemctl status iptables.service
   62  systemctl status iptables.service
   63  systemctl status iptables.service
   64  systemctl status iptables
   65  systemctl
   66  sudo systemctl
   67  su -i
   68  su
   69  iptables stop
   70  service iptables stop
   71  service iptables run
   72  service iptables start
   73  service iptables start
   74  iptables --list-all
   75  iptables --list
   76  iptables -L --line-numbers
   77  iptables -D INPUT 45
   78  iptables -A INPUT 12 -p tcp --dport 443 -j ACCEPT
   79  iptables -A INPUT 12 -p tcp --dport 443 -j ACCEPT
   80  iptables -I INPUT 12 -p tcp --dport 443 -j ACCEPT
   81  iptables-save
   82  ifconfig eth0 192.168.1.50 netmask 255.255.255.0 up
   83  ifconfig eth1 down
   84  ip a
   85  ping ya.ru
   86  ping 1.1.1.1
   87  reboot now
   88  shutdown -r
   89  vi /etc/network/interfaces
   90  ip a
   91  shutdown -r
   92  now
   93  ip a
   94  ping ya.ru
   95  vim /var/wab/etc/wabrestapi.conf
   96  add_api_key -n node1
   97  add_api_key -n nodeA -s
   98  add_api_key -n nodeA -s 192.168.1.51
   99  Add_api_key -n nodeA -s 192.168.1.51
  100  add_api_key -n nodeA
  101  add_api_key -n nodea
  102  add_api_key -n A
  103  add_api_key -n "A"
  104  add_api_key -n "a"
  105  add_api_key
  106  change
  107  del_api_k
  108  help
  109  WABConsole –u admin –c “WnqDV3HTs6J8NTVDP8mG3TZuASg0en5CjQLJt7K2nlg –n 192.168.1.51”
  110  pvd ~/
  111  cd ~/
  112  pwd
  113  cd /home/wabadmin/
  114  mv ./api_key_nodeB ./api_key_nodeB.txt
  115  vi ./api_key_nodeB.txt
  116  vi ./api_key_nodeB.txt
  117  cp ./api_key_nodeB.txt ./api_key_nodeA.txt
  118  vi ./api_key_nodeA.txt
  119  hostname
  120  hostname -?
  121  hostname -b wallix-a
  122  hostname
  123  whoami
  124  whoami
  125  ls
  126  exit
  127  ip a
  128  whoami
  129  ip a
  130  ping ya.ru
  131  whoami
  132  WABConsole
  133  WABConsole -u admin -c "list_api_key"
  134  WABConsole --helpWABConsole --help
  135  WABConsole --help
  136  cd /opt/skdpu/
  137  ls
  138  cd scripts/
  139  ls
  140  cd ..
  141  cd ..
  142  ls
  143  cd wab/
  144  ls
  145  cd ./bin/
  146  ls
  147  ls |grep log
  148  ./WABJournalCtl
  149  ls -la
  150  ./WABSessionLogExport
  151  vi /etc/network/interfaces
  152  cd ./.tools/
  153  ls
  154  mc
  155  hostname
  156  exit
  157  exit

   



success
:alien: Системный администратор
## Паламарчук Антон

:e-mail: Email: mrpalamarchuk93@gmail.com
:airplane: Telegram Channel [@ipraptor_blog](https://t.me/ipraptor_blog)
:incoming_envelope: Telegram [@IPraptor](https://t.me/IPraptor)



<style>
.button {
border-radius: 4px;
color: rgb(0, 41, 123);
display:block;
text-align: center;
font-family: Arial, Helvetica, sans-serif;
font-size: 100%;
padding: 10px 25px;
margin-top: 1%;
margin-left: 1%;
text-decoration: none;
background-color: rgb( 213, 233, 255);
border: none;
display:inline-block;
}
a.back{
border-radius: 4px;
color: black;
display:block;
width:157px;
text-align: center;
font-weight:bold;
font-family: Arial, Helvetica, sans-serif;
font-size: 14px;
padding: 8px 16px;
margin: left;
margin-top: 50px;
text-decoration: none;
background-color: rgb(255,237,55);
}

</style>

<a href="https://hackmd.io/@IPraptor
" class="back">К списку заметок</a>
