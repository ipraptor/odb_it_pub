# Kaspersky Endpoint Security CLI
#Kaspersky Security Center #KESL #Linux #CLI 

Перенос агента касперского на другой сервер администрирования
   bash=
/opt/kaspersky/klnagent64/bin/klmover -address 192.168.123.124
   
Перезапуск агента
   bash=
/opt/kaspersky/klnagent64/bin/klnagchk -restart
   
Проверка состояния агента и вывод его настроек
   bash=
/opt/kaspersky/klnagent64/bin/klnagchk
   


systemctl --type=service |grep kaspersky
systemctl --type=service |grep kesl


/etc/init.d/klnagent64 restart

systemctl restart klnagent64.service
systemctl status klnagent64.service

systemctl restart kesl.service
systemctl status kesl.service


Для настройки агента есть отдельный скрипт /opt/kaspersky/klnagent64/lib/bin/setup/klnagent_setup.pl

