# Конвертация Evaluation лицензии в Standart на Windows server
#Windows_server #CLI 

   bash=
dism /online /set-edition:ServerStandard /productkey:WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY /accepteula
   

## Для апгрейда Windows Server 2016 Eval до Datacenter редакции, нужно использовать другой GVLK ключ. Полностью команда апгрейда выглядит так:
   bash=
DISM /online /Set-Edition:ServerDatacenter /ProductKey:CB7KF-BWN84-R7R2Y-793K2-8XDDG /AcceptEula
   
## Конвертировать Windows Server 2019 Evaluation в Windows Server 2019 Standard:
   bash=
dism /online /set-edition:ServerStandard /productkey:N69G4-B89J2-4G8F4-WWYCC-J464C /accepteula
   
## Чтобы конвертировать Windows Server 2019 Evaluation в Windows Server 2019 Datacenter, выполните:
   bash=
dism /online /set-edition:ServerDatacenter /productkey:WMDGN-G9PQG-XVVXX-R3X43-63DFG /accepteula
   

## Команда для конвертации Windows Server 2022 Evaluation редакции в Standard:
   bash=
dism /online /set-edition:serverstandard /productkey:VDYBN-27WPP-V4HQT-9VMD4-VMK7H /accepteula
   
## Конвертировать в Windows Server 2022 Datacenter:
   bash=
dism /online /set-edition:serverdatacenter /productkey:WX4NM-KYWYW-QJJR4-XV3QB-6VM33 /accepteula
   


---



Возможные ошибки DISM:

 The current edition cannot be upgraded to any target editions — значит вы пытаетесь конвертировать Datacenter редакцию в Такое направление обновления не поддерживается.
Есть неофициальный способ даунгрейда редакции Windows Server с Datacenter до Standard.
 Error: 50. Setting an Edition is not supported with online images — скорее всего говорит о том, что на сервер развернута роль контроллера домена Active Directory (роль AD DS). Конвертация редакции Windows Server на DC не поддерживается.
 This Windows image cannot upgrade to the edition of Windows that was specified. The upgrade cannot proceed. Run the /Get-TargetEditions option to see what edition of Windows you can upgrade to — ошибка появляется если вы попытаетесь преобразовать Windows Server Evaluation Datacenter в Standard. Мы уже раньше писали, что нельзя обновить Eval Datacenter до Standard. Вам нужно преобразовать редакцию ServerDatacenterEval в ServerDatacenter. Укажите в команде DISM KMS ключ для Datacenter редакции Windows Server.
