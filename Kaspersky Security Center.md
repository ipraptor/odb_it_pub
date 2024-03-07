# Kaspersky Security Center
#Kaspersky Security Center #AntiVirus 


# Важные для работы сервисы KSC
|Отоброжаемое имя|Имя службы|
|---|---|
|Kaspersky Seamless Update Service|avpsus|
|SQL Server (KAV_CS_ADMIN_KIT)|MSSQL$KAV_CS_ADMIN_KIT|
|Агент администрирования Kaspersky Security Service|klagent|
|Веб-сервер "Лаборатории Касперского"|klwebsrv|
|Сервер администрирования Kaspersky Security Center|kladminserver|

success
:information_source: Данные службы должны быть запущены


# Порты для работы
13000 udp - рассылка команды запуска форсированного обновления
15000 tcp - обратное подключение
13291 **SSL для консоли администрирования**
13299 Порт веб консоли
14000 порт без ssl сервера
19170 RDP порт для KSC 13.2 web console
17000 SSL порт сервера активации
13292 Порт для мобильных устройств синхронизация
17100 порт для активации моб устройств
13294порт для устройств с защитой на уровне UEFI и устройств с Kaspersky OS 
13296 Prometeus
8060 http порт веб сервера
8061 https
5672 Порт агента сообщений
3128 Прокси
