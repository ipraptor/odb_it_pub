#!/usr/bin/env bash
set -euo pipefail

# SSH over TLS — Ubuntu Server
# Внешний порт: 443
# Внутренний SSH: 127.0.0.1:22

if [ "$EUID" -ne 0 ]; then
    echo "Запусти скрипт через sudo"
    exit 1
fi

echo "[1/6] Установка Stunnel..."

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y stunnel4 openssl

echo "[2/6] Настройка SSH..."

# Проверяем, что SSH доступен на порту 22.
if ! ss -lnt | grep -qE ':22[[:space:]]'; then
    echo "ОШИБКА: SSH не слушает порт 22."
    echo "Проверь конфигурацию SSH перед продолжением."
    exit 1
fi

# Для Ubuntu с systemd socket activation:
# убираем ранее добавленный SSH-порт 443,
# оставляя порт 22.
if systemctl is-active --quiet ssh.socket; then
    mkdir -p /etc/systemd/system/ssh.socket.d

    cat > /etc/systemd/system/ssh.socket.d/ssh-tls.conf <<'EOF'
[Socket]
ListenStream=
ListenStream=22
EOF

    systemctl daemon-reload
    systemctl restart ssh.socket
fi

# Не пытаемся занять порт, если он используется.
if ss -lnt | grep -qE ':443[[:space:]]'; then
    echo "ОШИБКА: порт 443 уже занят."
    echo "Проверь: ss -lntp | grep ':443'"
    echo "Если его слушает sshd, убери Port 443 из sshd_config."
    exit 1
fi

echo "[3/6] Создание TLS-сертификата..."

mkdir -p /etc/stunnel

openssl req -x509 \
    -newkey rsa:3072 \
    -sha256 \
    -nodes \
    -days 365 \
    -keyout /etc/stunnel/ssh.key \
    -out /etc/stunnel/ssh.crt \
    -subj "/CN=ssh-tunnel" \
    -addext "subjectAltName=DNS:ssh-tunnel"

cat /etc/stunnel/ssh.key /etc/stunnel/ssh.crt \
    > /etc/stunnel/ssh.pem

chmod 600 /etc/stunnel/ssh.key
chmod 600 /etc/stunnel/ssh.pem
chmod 644 /etc/stunnel/ssh.crt

echo "[4/6] Настройка TLS-туннеля..."

cat > /etc/stunnel/ssh.conf <<'EOF'
client = no
foreground = no

[ssh]
accept = 0.0.0.0:443
connect = 127.0.0.1:22

cert = /etc/stunnel/ssh.pem
EOF

# Разрешаем автоматический запуск службы.
if grep -q '^ENABLED=' /etc/default/stunnel4; then
    sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/stunnel4
else
    echo 'ENABLED=1' >> /etc/default/stunnel4
fi

echo "[5/6] Запуск службы..."

systemctl enable stunnel4
systemctl restart stunnel4

echo "[6/6] Проверка..."

if ! systemctl is-active --quiet stunnel4; then
    echo "ОШИБКА: Stunnel не запустился."
    journalctl -u stunnel4 -n 20 --no-pager
    exit 1
fi

if ! ss -lnt | grep -qE ':443[[:space:]]'; then
    echo "ОШИБКА: порт 443 не прослушивается."
    exit 1
fi

echo
echo "======================================"
echo " SSH OVER TLS ЗАПУЩЕН"
echo "======================================"
echo
echo "TLS: TCP 443"
echo "SSH: TCP 22"
echo
echo "Сертификат для Windows:"
echo "/etc/stunnel/ssh.crt"
echo
echo "Проверка портов:"
ss -lntp | grep -E ':22[[:space:]]|:443[[:space:]]'
echo
echo "Готово!"
