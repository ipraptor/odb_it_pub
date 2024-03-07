# Автоматизация выполнения команд на рабочих местах Windows
#Windows #CLI #SysInternals 

# Инструментарий

Для выполнения команд на удалённых рабочих местах мы будем использовать комплект инструментариев [**SysInternals**](https://docs.microsoft.com/en-us/sysinternals/) от [Марка Руссиновича](https://docs.microsoft.com/ru-ru/archive/blogs/markrussinovich/) в частности утилитой [**PSexec.**](https://docs.microsoft.com/en-us/sysinternals/downloads/psexec)
При наличии инструмента winget SysInternals устанавливается в одну команду PowerShell
   
winget install sysinternals
   
spoiler действия в случае если winget отсутствует
- Если winget отсутствует его можно скачать отсюда - [**гитхаб**](https://github.com/microsoft/winget-cli/releases)
и установить этот файл
 Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle 

- Либо установить отсюда скачать и установить напрямую [**SysInternals**](https://docs.microsoft.com/en-us/sysinternals/)


Для выполнения подключения к удалённому компьютеру используем такой синтаксис

# Возможности PsExec
Синтаксис утилиты:
success
 psexec.exe \\\[ip-адрес-подключения] [команда] 

Примеры:
 psexec.exe \\\10.2.101.116 cmd 

При этом откроется окно командной строки в котором можно полноценно исполнять любые команды

![](https://i.imgur.com/FAaTe9x.png)

Вместо cmd можно запустить PowerShell для доступа к ресурсам PS

![](https://i.imgur.com/nxj7mMJ.png)

Так-же можно исполнять однострочные команды, после вывода psexec отключится от удалённого компьютера

![](https://i.imgur.com/0hncP3z.png)

## Массовое исполнение команд

Так-же PsExec может исполнять команды для списка компьютеров занесённого в текстовый документ.
success
Синтаксис следующий:
 psexec @[буква диска]:\[имя файла со списком пк].txt [команда] 

 psexec @c:\pc.txt ipconfig 

Кроме этого можно выполнить несколько команд объединив их двойным амперсандом как это делается в синтаксисе powershell

 psexec @c:\pc.txt "powershell.exe ipconfig /release && ipconfig /renew" 


success
У удалённого исполнения команд через PSexec есть ещё один приятный побочный эффект
**Кэширование той учётной записи с которой выполнена команда.**
Т.е. если вам необходимо закэшировать учётку администратора на паре сотен машин, нет необходимости бегать и логиниться в каждой, достаточно команды в пару строк.



   


   
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





