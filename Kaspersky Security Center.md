# Kaspersky Security Center
#Kaspersky Security Center #AntiVirus 


# Важные для работы сервисы KSC
(ДАННЫЕ СЛУЖБЫ ДОЛЖНЫ БЫТЬ ЗАПУЩЕНЫ)

|Отоброжаемое имя|Имя службы|
|---|---|
|Kaspersky Seamless Update Service|avpsus|
|SQL Server (KAV_CS_ADMIN_KIT)|MSSQL$KAV_CS_ADMIN_KIT|
|Агент администрирования Kaspersky Security Service|klagent|
|Веб-сервер "Лаборатории Касперского"|klwebsrv|
|Сервер администрирования Kaspersky Security Center|kladminserver|




# Порты для работы

|Номер порта|Процесс|Протокол|Назначение|Область|
|---|---|---|---|---|
|445| | TCP |SMB для первичного развертывания агента|
|139| | TCP |Для инициализации удалённой команда на установку агента|
|8060|klcsweb|TCP|Публикация инсталляционных пакетов|Сервер администрирования|
|8061|klcsweb|TCP (TLS)|Публикация инсталляционных пакетов|Сервер администрирования|
|13000|klserver|TCP (TLS)|Подключения от агентов|Управление клиентами|
|13000|klserver|UDP|Информация от агентов|Управление клиентами|
|13291|klserver|TCP (TLS)|Подключения от консоли|Управление сервером|
|13299|klserver|TCP (TLS)|Соединения от Web Console|Kaspersky Web Console|
|14000|klserver|TCP|Подключения от агентов|Управление клиентами|
|13111|ksnproxy|TCP|Запросы к прокси-серверу KSN|Прокси-сервер KSN|
|15111|ksnproxy|UDP|Запросы к прокси-серверу KSN|Прокси-сервер KSN|
|17000|klactprx|TCP (TLS)|Активация программ|Прокси-сервер активации|
|443|kliosmdmservicesrv|TCP (TLS)|Соединения от MDM|Управление мобильными устройствами|
|8080|Node.js|TCP (TLS)|Соединения от Web Console|Kaspersky Web Console|
|15000|klnagent|UDP|Управление от сервера|Управление клиентами|
|15001|klnagent|UDP|Многоадресная рассылка|Доставка обновлений|
|13295|klnagent|TCP (TLS)|Push-уведомления|Push-сервер|
