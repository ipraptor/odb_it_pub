# **SCSI на Windows в Proxmox 6.4**
#Proxmox #Windows #SCSI #Drivers 
При создании VM на Proxmox 6.4 появляется возможность выбора вида контроллера диска
SCSI является самым быстрым способом соединения в данном случае, однако имеет существенный недостаток.

![](https://i.imgur.com/BZosGQS.png)

При его выбора установка ОС Windows становится затруднительна, т.к. встроенная система не имеет на борту драйверов SCSI, по причине этого при установке появится ошибка при которой виртуальные диски не видны целевой системе.

![](https://i.imgur.com/6C4U1xQ.png)

Для решения данной проблемы можно подкинуть драйвер в систему.
Скачать драйвер SCSI можно здесь
https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso
Загружаем образ в Proxmox 

![](https://i.imgur.com/Ck116Iq.png)

Добавляем CD устройство, подключаем в ISO image iso файл с драйвером скачанным выше, и перезапускаем VM

![](https://i.imgur.com/ccEn6GP.png)

В VM доходим до окна с ошибкой и жмём загрузить

![](https://i.imgur.com/6C4U1xQ.png)

Далее переходим на примонтированный диск с драйверами и в директории viscsi находим свою ОС
и выбираем вложенную папку.

![](https://i.imgur.com/3RMD7XQ.png)

После этого в списке появятся драйверы от SCSI, выбираем любой 

![](https://i.imgur.com/BbQaluB.png)

После установки драйверов обнаруживаем что диски успешно определились

![](https://i.imgur.com/0HYRQxe.png)


success
:alien: Системный администратор
## Паламарчук Антон

:e-mail: Email: mrpalamarchuk93@gmail.com
:airplane: Telegram Channel [@ipraptor_blog](https://t.me/ipraptor_blog)
:incoming_envelope: Telegram [@IPraptor](https://t.me/IPraptor)**

