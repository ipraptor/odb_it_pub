# CheckPoint
#CheckPoint #NGFW #UTM 

# ====Аннотация====

Информация представленная ниже, ничто иное, как конспект с моими авторскими пометками по курсам
[Check Point Getting Started R80.20 от TS Solution](https://www.youtube.com/playlist?list=PLqio-3dnMW5_2cStMfIezwcAzzDCjX86C) 
[Check Point на максимум от TS Solution](https://www.youtube.com/watch?v=us2gfs5m56E&list=PLqio-3dnMW5-q1IHBK3RClRp3n2SE-L1x)
[Check Point Remote Access VPN от TS Solution](https://tssolution.ru/katalog/checkpoint/online_course_remote_access_vpn?utm_source=youtube&utm_campaign=ravpn)

Возможно в будущем сформирую из представленной каши вменяемый гайд для новичка

# ====Общая информация====
![](https://i.imgur.com/CMq4g08.png)

---

![](https://i.imgur.com/FnMAfAQ.png)
![](https://i.imgur.com/186wAaO.png)

danger
:a: Внимание, при развёртывании Standalone сервера Блейд *Smart Event* будет недоступен. Т.е. Smart Event - доступен только для Distributed :a:


## ====Краткое описание функционала блейдов:====

**Firewall** — функционал межсетевого экрана;
**IPSec VPN** — построение частные виртуальных сетей;
**Mobile Access** — удаленный доступ с мобильных устройств;
**IPS** — система предотвращения вторжений;
**Anti-Bot** — защита от ботнет сетей;
**AntiVirus** — потоковый антивирус;
**AntiSpam & Email Security** — защита корпоративной почты;
**Identity Awareness** — интеграция со службой Active Directory;
**Monitoring** — мониторинг практически всех параметров шлюза (load, bandwidth, VPN статус и т.д.)
**Application Control** — межсетевой экран уровня приложений (функционал NGFW);
**URL Filtering** — безопасность Web (+функционал proxy);
**Data Loss Prevention** — защита от утечек информации (DLP);
**Threat Emulation** — технология песочниц (SandBox);
**Threat Extraction** — технология очистки файлов;
**QoS** — приоритезация трафика.

![](https://i.imgur.com/cc9seEd.png)

## ====Ресурсы====

![](https://i.imgur.com/obgRGkm.png)

# ====Установка====

![](https://i.imgur.com/4hygypa.png)

![](https://i.imgur.com/ZNfvHFQ.png)

> [!Note]
:a:
Под Root на продакшен системах нужно выделять не менее 30гб
:a:


# ====Настройки====
![](https://i.imgur.com/cGoPAj0.png)
![](https://i.imgur.com/BxeTz81.png)
![](https://i.imgur.com/bdPsFWu.png)
> [!Note]
:a: 
Перед скачиванием, SmartConsole, да и началы работы в целом, очень желательно обновить все компоненты. Это поможет избежать некоторых багов в дальнейшем. Сделать это можно через веб управление SMS, в самом низу основной колонки настроек, во вкладке Upgrades(Status and Actions), естественно после настройки интерфейса External.  А так же  после подключения SG к SMS. Что бы у SMS был выход в интернет.
:a:

> [!Note]
:a:
Одновременно в режиме редактирования подключаться к Check Point может быть осуществлён только один коннект с правами редактирования. Чтобы снять это нажмите на Замок в WebGUI или введите
   bash=
lock database override
   
:a:


![](https://i.imgur.com/EulAe8k.png)
![](https://i.imgur.com/FnkmKtw.png)

> [!Note]
:a: **https инспекция конфликтует с** опцией в Advance Settings для Application control (URL Filtring - **Categorize HTTPS website**) :a:


# Типы политик
![](https://i.imgur.com/Ap047qL.png)
![](https://i.imgur.com/iyMaewW.png)

![](https://i.imgur.com/VAcWeiB.png)
![](https://i.imgur.com/baWaHQO.png)
![](https://i.imgur.com/rT4HDYy.png)

![](https://i.imgur.com/OoDv1Mi.png)

![](https://i.imgur.com/jeINHvq.png)
Proxy режим работает только при существовании последовательных слоёв

![](https://i.imgur.com/Br8HCIA.png)
![](https://i.imgur.com/yk9RbWM.png)
![](https://i.imgur.com/89llWMr.png)

![](https://i.imgur.com/1vZGjG1.png)



# ====NAT====

![](https://i.imgur.com/LA0hcXX.png)
![](https://i.imgur.com/IDP5XEy.png)
![](https://i.imgur.com/p4zwM81.png)

# ====Content Awareness====
![](https://i.imgur.com/3fClHs7.png)


# ====Identity Awareness====
![](https://i.imgur.com/h8sG7nt.png)

![](https://i.imgur.com/uKqV1II.jpg)

> [!Note]
:a:
При активации *Identity Awareness* на странице "Select an Active Directory" необходимо использовать **УЗ ActiveDirectory с правами администратора домена**.

**ЛИБО**

Создать специальную УЗ с урезанными провами создание которой **описано в [sk93938 (клац)](https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk93938)**
:a:

![](https://i.imgur.com/hy9E5vc.png)

> [!Note]
:a: На машине со смарт консолью должен быть доступ к контроллеру домена :a:


![](https://i.imgur.com/jLmnNPB.png)

![](https://i.imgur.com/fPJDiko.png)
![](https://i.imgur.com/6npkX2b.png)

## ====Identity Awareness Troubleshooting====

![](https://i.imgur.com/s4Pc7od.png)



# ====Thread Prevention====

![](https://i.imgur.com/1cJKueq.png)

# ====Logs & Monitor====

![](https://i.imgur.com/QdQdgBJ.png)
> [!Note]
:a: Можно забивать в поиск произвольный тест или любым другим индексируемым параметрам и объединять запросы логическими операторами :a:

![](https://i.imgur.com/AGchvij.png)

![](https://i.imgur.com/lWQsmzN.png)
Smart Event - визуализация информации с помощью дашбордов
![](https://i.imgur.com/2EpcaoP.jpg)
> [!Note]
:a: Хорошая практика:
Выносить SmartEvent на отдельный сервер т.к. может быть высокое потребление ресурсов, если архитектура очень большая рекомендуется выносить на отдельный сервер Logs:a:


# ====Лицензирование==== 


![](https://i.imgur.com/IAh60SR.png)
> [!Note]
**Купить устройство или виртуалку** можно **только с подписками NGTP или NGTX**, а при продлении (через год) можно купить подписку NGFW, в случае если блейды включённые в подписки NGTP и\или NGTX вам не нужны


success
**Perpetual blade** - "вечные" блэйды (работающие без подписки)

В их список входят:
Firewall
Identiry awareness
IPSec VPN
Advanced Networking & Clistering
Mobile Access (5 users)
Network Policy Management
Logging and Status


![](https://i.imgur.com/6KpmaMY.png)

![](https://i.imgur.com/RDkco2d.png)

# ====https инспекция====
![](https://i.imgur.com/GJ4Mpnq.png)

![](https://i.imgur.com/ztD0DdF.png)
![](https://i.imgur.com/OORK6RU.png)
![](https://i.imgur.com/rZbVcaT.png)

# ====Content Awareness====
![](https://i.imgur.com/aVFHLAj.png)

> [!Note]
:a: Хорошая практика запретить скачивание исполняемых файлов для пользователей которым это не необходимо для работы :a:


![](https://i.imgur.com/Hi5F5H3.png)
![](https://i.imgur.com/NZh8qkf.png)
![](https://i.imgur.com/JjWrwpr.jpg)
![](https://i.imgur.com/LbkhyKY.png)

# ====Anti-Virus====
![](https://i.imgur.com/qQ7AADk.png)

![](https://i.imgur.com/SbidUj7.png)
![](https://i.imgur.com/hrxSuLC.png)
> [!Note]
:a: Хорошей практикой является включать Prevent во вкладке Activions - Malicious Activity :a:

![](https://i.imgur.com/nMiZBME.png)

## ====Запрет скачивания архивов если архив битый и его невозможно проверить (не работает с запароленными архивами)====
![](https://i.imgur.com/Dmf8Bw7.png)

## ====Запрет скачивания запароленных архивов====
![](https://i.imgur.com/KyVFTsG.png)

# ====IPS====

## ====IPS теория====
spoiler теоритическая информация по IPS
![](https://i.imgur.com/1jlxBpw.png)
![](https://i.imgur.com/1vXQGuB.png)
![](https://i.imgur.com/zKb8ShX.png)
![](https://i.imgur.com/bHu1QVQ.png)
![](https://i.imgur.com/YH0ORoj.png)
![](https://i.imgur.com/Jgu7296.png)
![](https://i.imgur.com/rKztP8a.png)
![](https://i.imgur.com/tNa6LBD.jpg)
![](https://i.imgur.com/OPoTUvl.png)
![](https://i.imgur.com/2ygfdtK.png)
![](https://i.imgur.com/sJGRAs7.png)


## ====IPS практика====

> [!Note]
:a: Хорошие практики настройки IPS на CheckPoint можно почитать [**здесь (клац)**](https://sc1.checkpoint.com/documents/Best_Practices/IPS_Best_Practices/CP_R80.10_IPS_Best_Practices/html_frameset.htm) :a:


![](https://i.imgur.com/pdvvXKz.png)

> [!Note]
:a: Обновляйте сигнатуры IPS пару раз в неделю :a:


![](https://i.imgur.com/MkA4GAL.png)

> [!Note]
:a: Все новые сигнатуры преходят в режим Detected, после ручного анализа на то что новые сигнатуры не рушат легетимный трафик, сигнутуры переводятся в режим Prevent :a:


![](https://i.imgur.com/AD2BLxh.png)

Очистка профиля от Staging сигнатур производится в меню Actions ![](https://i.imgur.com/xEsfUEO.png)

1) Создаём отдельный Layer для блейда IPS, с Threat Prevention убираем блейд IPS
![](https://i.imgur.com/GJVUG4B.png)

2) Разделяем пользовательские и серверные сигнатуры на два профиля
![](https://i.imgur.com/4EsTqs7.png)

3) Задаём индивидуальные настройки для профиля пользовательского сегмента и серверного
![](https://i.imgur.com/7FVhlzr.png)
![](https://i.imgur.com/sRRgzU5.png)

4) Так же, аналогично, настраиваем сигнатуры на Servers, для примера:
![](https://i.imgur.com/QKQEe3i.png)

Так-же есть настраиваемые сигнатуры, например связанные с брутфорсом
![](https://i.imgur.com/iM2SNBO.png)
![](https://i.imgur.com/C8PKfsw.png)

Так-же имеются исключения которые можно добавлять для конкретных хостов, конкретных сигнатур и т д
![](https://i.imgur.com/SB1D4YH.png)

**Резюмирование.
Главные идеи правильной настройки IPS:**
1) **Вынести IPS в отдельный Layer**
2) **Создать несколько политик для разных сегментов**
3) **Выбрать только нужные сигнатуры, релевантные для данной сети\конечных устройств с помощью фильтров**

# ====Sandboxing====

![](https://i.imgur.com/6ObQKC3.png)

![](https://i.imgur.com/muwzpHT.png)

![](https://i.imgur.com/npoQ7IQ.png)

# ====SecureXL====
![](https://i.imgur.com/0MkLrAR.png)
![](https://i.imgur.com/HDBhprb.png)

![](https://i.imgur.com/iMsAkaV.png)
ПЕРВЫЙ ПАКЕТ
![](https://i.imgur.com/OywXC8Q.png)
ПОСЛЕДУЮЩИЕ ПАКЕТЫ В СЛУЧАЕ ЕСЛИ СЕССИЯ БЕЗОПАСНА
![](https://i.imgur.com/ScCOPVQ.png)

![](https://i.imgur.com/7dTEqco.png)

![](https://i.imgur.com/EeSpzhf.png)
![](https://i.imgur.com/SVVktoh.png)
![](https://i.imgur.com/wv9UEeF.png)
![](https://i.imgur.com/3ZQQffK.png)
![](https://i.imgur.com/3S94NLc.png)

# ====CoreXL====

![](https://i.imgur.com/Nk7B6z8.png)
![](https://i.imgur.com/P3wbuGv.png)
![](https://i.imgur.com/WTBq0So.png)
![](https://i.imgur.com/ni5tqGp.png)
![](https://i.imgur.com/Sym7nXo.png)
![](https://i.imgur.com/JaTxxpR.png)
![](https://i.imgur.com/2ioOIsB.png)
![](https://i.imgur.com/1xSRyFN.png)
![](https://i.imgur.com/wOH6X83.png)
> [!Note]
:a: При добавлении ядер на OpenServer или виртуалке ядра автоматически не добавляются их необходимо добавлять вручную :a:

![](https://i.imgur.com/WA8b6Fx.png)

![](https://i.imgur.com/A4jV24M.png)
Распределение нагрузки исходя из загруженности ядра и очереди
По умолчанию динамическая очередь отключена
![](https://i.imgur.com/ZQIo4Z0.png)

![](https://i.imgur.com/iD7NiJy.png)


# Эффективность
![](https://i.imgur.com/OrOF70f.png)
На VMware нет существенного прироста к производительности при добавлении более 6 ядер
![](https://i.imgur.com/Xv8Domx.png)


![](https://i.imgur.com/xmfUKq1.png)



# ====Check Point VPN====
![](https://i.imgur.com/BGMhXc4.png)
![](https://i.imgur.com/3vvsVwy.png)






   


   
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
