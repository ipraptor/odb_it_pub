# CheckPoint - Remote Access VPN
#CheckPoint #CLI #VPN 

sk67820 - Сам VPN
sk166032 - ЧаВО
sk67820 - Скачать клиент
[Центр загрузки](https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk117536)
# Алгоритм настройки
* Создать объект на CheckPoint
* Создать группу подсетей
* Пролить политику
* Проверить работу
* Включаем блейд IPsec
* Настраиваем Office Mode
* Указываем там DNS сервер
* Активируем Visitor Mode 
* Создаём 

![](https://i.imgur.com/yXt3RAC.png)

## h3
* **Активируем Blade IPsec VPN**
    spoiler
    ![](https://i.imgur.com/ZhfbaVP.png)
    После активации появится вкладка VPN Clients ![](https://i.imgur.com/AT07GT5.png)
    В ней можно наблюдать какие елиенты могут подключаться к CP
    > [!Note]
    SecuRemote отключить если не используете
    
    При использовании одного провайдера так же лучше указать в Link selection адресе и интерфейсе на котором будет прослушиваться IPsec 
    ![](https://i.imgur.com/aB1AyOD.png)

    
    * **Настраиваем подункты CLients VPN**
        spoiler
        ![](https://i.imgur.com/t2pGSfV.png)
        * **Активируем Office mod**
            > [!Note]
            **Office mode** - это когда шлюз выдаёт клиенту IP адрес из специального пулла. ***При этом расходуются лицензии Mobile Access***
            
            ![](https://i.imgur.com/YoD2O1i.png)
        * **Во вкладке Remote Access активируем Support Visitor Mode**
            ![](https://i.imgur.com/SlOa6wX.png)
            > [!Note]
            **Support Visitor Mode** открывает 80 и 443 порты для того чтобы клиент мог инициировать VPN соединение. **Без могут работать L2TP и SecuRemote**.
            Так-же если Support Visitor Mode используется из-за того что он занимает 443 порт нужно поменять порт обращения для веб интерфейса используемого для настройки на произвольный ![](https://i.imgur.com/3s1bV90.png) + не забыть добавить правило FW разрешающее админу по этому порту обращаться к шлюзу
            
* **Настраиваем VPN Community**
    * Находим VPN Community "Remote access" и указываем в нём наш шлюз и сеть за шлюзом к которой даётся доступ клиентам.
        ![](https://i.imgur.com/Wsoi6qd.png)
        > [!Note]
        Начиная с CP v 80.40 домен можно указывать в том же окне комьюнити, если CP ранней версии то это настраивается в свойствах шлюза
        ![](https://i.imgur.com/3RG5Cbo.png)
        
        
* **Создаём правило FW для клиентов**
    ![](https://i.imgur.com/mKiO9ov.png)
    ![](https://i.imgur.com/oJs64KD.png)
    Создаём шаблон для пользователей
    ![](https://i.imgur.com/NCdaTpR.png)
    Создаём пользователей и задаём им пароль (телефон почту если 2fa)
    ![](https://i.imgur.com/tVcl6IX.png)
    В Source созданного ранее правила FW добавляем группу юзеров


Если мы хотим использовать подключение под УЗ AD то тыкаем галку в Identity Awareness- Remote access ![](https://i.imgur.com/7usdUA9.png)
Добавляем Access роль
Создаём на КД нужную группу и пихаем туда юзеров для VPN


Если нам необходимо подключить Remote Access пользователя таким образом чтобы весь трафик выходящий в интернет шёл через CheckPoint - ставим вот эту галочку
![](https://i.imgur.com/ET9ygsX.png)
а также в глобальных конфигурациях в Securety Setting поставить либо Yes либо Configured on endpoint client (что даст право клиенту выбирать самому)
![](https://i.imgur.com/Sir4HoA.png)


