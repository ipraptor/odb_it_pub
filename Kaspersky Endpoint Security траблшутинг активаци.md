# Ошибка A0430008 при активации Kaspersky Endpoint Security
#AntiVirus #Kaspersky Security Center 

# Проблема
Во время распространения лицензии Kaspercky Endoint Secority через Security Center, в ряда устройств появляется ошибка активации

# Решение
Проверьте что у вас имеется доступ по https (tcp/443) к адресу
activation-v2.kaspersky.com

Сделать это можно командой powershell
   bash=
tnc activation-v2.kaspersky.com -port 443
   
В случае если вывод команды отличается от приведённого ниже (имеет вывод false или аналогичный)
![](https://i.imgur.com/NzIeBue.png)
Необходимо это изменить внеся изменения в конфигурацию сетевого оборудования.

> [!Note]
:information_source: Для активации лицензии сервер Kaspersky security center должен иметь доступ к "activation-v2.kaspersky.com/activationservice/activationservice.svc"
В противном случае активация будет возможна через лицензионный файл.


## Как получить лицензионный файл

Зайти на сайт [https://keyfile.kaspersky.com/ru/](https://keyfile.kaspersky.com/ru/) и сгенерировать ключевой файл из имеющегося у вас кода активации.
