# Шпаргалка по Docker
#Linux #CLI #Docker 
# Forwarding
Активировать Forwarding linux
   
sysctl -w net.ipv4.ip_forward=1
   

# Статус и удаление

Статус контейнеров 
    docker ps#  

Остановка работы контейнера
    docker stop nginx#  

Запуск работы контейнера
    docker start nginx#  

Посмотреть логи
    docker logs container_name#  

Удаление контейнера
    docker rm --force nginx   
(ключ --force позволяет удалять работающие контейнеры)

Подробности контейнера
   docker container inspect nginx   

---
Список образов
    docker images#  
Удаление образа
    docker rmi nginx#  

# Установка

Скачивание и установка контейнера
    docker run -d nginx#  

-- || -- с назначением имени
    docker run -d --name=container_name nginx   

-- || -- и назначением порта прослушивания
   
docker run -d --name=container_name -p 0.0.0.0:8080:80 nginx
   
> [!Note]
:+1: Первым указывается порт прослушиваемый снаружи, вторым тот на который перенаправится трафик в контейнер, если вместо IP указать 127.0.0.1 чтобы контейнер был доступен только из docker, так-же можно добавить ещё один блок -p c ip адресом чтобы привязать контейнер к нескольким IP адресам.

Можно открыть и UDP порты
   
docker run -d --name=container_name  -p 192.168.100.50:80:80/udp nginx
   
> [!Note]
:+1: По умолчанию Docker открывает TCP порты

Открываем диапазон портов
   
docker run -d -p 8090-8095:80-85 nginx
   
# Управление контейнером изнутри
Зайти в контейнер
   
docker exec -t -i conteiner_name /bin/bash
   
> [!Note]
:+1: /diff слой хранит информацию с изменениями внесенными после запуска контейнера от оригинального образа.


# Сборка Docker

=== СТАТЬЯ В ПРОЦЕССЕ НАПИСАНИЯ ===
