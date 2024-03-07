# Изменение языка вывода консоли в Linux
#Linux #CLI 

   bash=
nano /etc/default/locale
   
Закомментируйте всё строки с помощью символа #, кроме строки:
   bash
LANG="en_US.UTF-8"
   
Если такой строки нет — добавьте. Затем выполните команду:
   bash=
sudo locale-gen en_US.utf8
   
После этого сделайте logout, либо перезапустите ОС. Чтоб обновить недостающие языковые локализации, выполните:
   bash=
sudo apt-get update && apt-get upgrade.
   
