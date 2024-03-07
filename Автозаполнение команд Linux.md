# Автозаполнение команд Linux
#Linux #CLI #CentOS #Debian #Ubuntu #RHEL 

В Linux подобных системах есть возможность подключить функцию автозаполнения команд.

==1) После ввода первых 2-3 символов команды по нажатию клавиши вверх представляется выбор из ранее введённых команд==

Добавляем в конец файла#vi /etc/inputrc  следующие строчки

   
set show-all-if-ambiguous On
"\e[A": history-search-backward
"\e[B": history-search-forward
   

==2) После ввода первых 2-3 символов команды по нажатию клавиши Tab команда и её параметры автоматически дописывается.==

CentOS\RHEL:
 yum install bash-completion 

Debian\Ubuntu:
 apt-get install bash-completion 
