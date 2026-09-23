#!/usr/bin/env bash
set -Eeuo pipefail

# Ubuntu: SSH on 22 behind stunnel TLS on 443.
# IMPORTANT: run from your provider's VPS console or another verified access path.
# Changing ssh.socket can disconnect an SSH session currently using port 443.

SSH_PORT=22
TLS_PORT=443
CONF=/etc/stunnel/ssh-tls.conf
CERT=/etc/stunnel/ssh-tls.crt
KEY=/etc/stunnel/ssh-tls.key
PEM=/etc/stunnel/ssh-tls.pem
UNIT=/etc/systemd/system/ssh-tls.service
OVERRIDE=/etc/systemd/system/ssh.socket.d/99-ssh-tls.conf
BACKUP="/root/ssh-tls-backup-$(date +%Y%m%d-%H%M%S)"
SOCKET_CHANGED=0
COMPLETE=0

log() { printf '\n== %s ==\n' "$*"; }
fail() { echo "ERROR: $*" >&2; exit 1; }
listening() { ss -H -lnt "sport = :$1" | grep -q .; }

rollback() {
    if [[ "$COMPLETE" == 1 ]]; then return; fi
    echo 'Setup failed. Attempting to restore the previous ssh.socket settings.' >&2
    systemctl stop ssh-tls.service 2>/dev/null || true
    if [[ "$SOCKET_CHANGED" == 1 ]]; then
        if [[ -f "$BACKUP/socket-override" ]]; then
            cp -a "$BACKUP/socket-override" "$OVERRIDE"
        else
            rm -f "$OVERRIDE"
        fi
        systemctl daemon-reload || true
        systemctl restart ssh.socket || true
        systemctl restart ssh.service || true
    fi
    echo "Backups: $BACKUP" >&2
    echo 'Check remote access in the VPS console before disconnecting.' >&2
}
trap rollback EXIT

[[ $EUID == 0 ]] || fail 'Run as root: sudo bash setup-ssh-tls.sh'
command -v systemctl >/dev/null || fail 'systemd is required.'
[[ -x /usr/sbin/sshd ]] || fail 'OpenSSH server is missing: /usr/sbin/sshd'
/usr/sbin/sshd -t || fail 'sshd configuration failed validation.'
systemctl is-active --quiet ssh.socket || fail 'ssh.socket must be active; no SSH configuration changed.'

log 'Installing stunnel and openssl'
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y stunnel4 openssl
STUNNEL=$(command -v stunnel4) || fail 'stunnel4 binary not found.'

log 'Backing up existing configuration'
mkdir -p "$BACKUP" "$(dirname "$OVERRIDE")" /etc/stunnel
for file in "$OVERRIDE" "$CONF" "$UNIT" /etc/ssh/sshd_config; do
    if [[ -f "$file" ]]; then
        cp -a "$file" "$BACKUP/$(echo "$file" | tr / _)"
    fi
done
# An additional, predictable backup name is used for socket rollback.
[[ ! -f "$OVERRIDE" ]] || cp -a "$OVERRIDE" "$BACKUP/socket-override"

log 'Configuring ssh.socket for TCP 22'
cat > "$OVERRIDE" <<EOF
[Socket]
ListenStream=
ListenStream=$SSH_PORT
EOF
SOCKET_CHANGED=1
systemctl daemon-reload
systemctl restart ssh.socket
systemctl restart ssh.service
listening "$SSH_PORT" || fail 'Nothing listens on TCP 22.'
# Verify that a real SSH banner is received, not merely a successful TCP connect.
timeout 8 bash -c 'exec 3<>/dev/tcp/127.0.0.1/22; IFS= read -r -t 5 banner <&3; [[ "$banner" == SSH-2.0-* ]]' \
    || fail 'SSH on 127.0.0.1:22 does not return an SSH banner.'

log 'Checking availability of TCP 443'
if listening "$TLS_PORT"; then
    ss -lntp "sport = :$TLS_PORT" || true
    fail 'TCP 443 is still occupied. Check sshd_config, other ssh.socket overrides or web services.'
fi

log 'Preparing certificate'
if [[ -f "$CERT" && -f "$PEM" ]]; then
    echo 'Reusing existing TLS certificate and private key.'
elif [[ -e "$CERT" || -e "$PEM" || -e "$KEY" ]]; then
    fail 'Incomplete pre-existing certificate files; inspect /etc/stunnel before retrying.'
else
    openssl req -x509 -newkey rsa:3072 -sha256 -nodes -days 365 \
        -keyout "$KEY" -out "$CERT" \
        -subj '/CN=ssh-tunnel' -addext 'subjectAltName=DNS:ssh-tunnel'
    cat "$KEY" "$CERT" > "$PEM"
fi
chmod 600 "$PEM"
[[ ! -f "$KEY" ]] || chmod 600 "$KEY"
chmod 644 "$CERT"

log 'Creating dedicated foreground stunnel service (no PID file)'
cat > "$CONF" <<EOF
client = no
foreground = yes
sslVersionMin = TLSv1.2
cert = $PEM
[ssh]
accept = 0.0.0.0:$TLS_PORT
connect = 127.0.0.1:$SSH_PORT
EOF
chmod 600 "$CONF"
cat > "$UNIT" <<EOF
[Unit]
Description=SSH over TLS (stunnel)
After=network.target ssh.socket
Requires=ssh.socket

[Service]
Type=simple
ExecStart=$STUNNEL $CONF
Restart=on-failure
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable ssh-tls.service
systemctl restart ssh-tls.service
sleep 2
if ! systemctl is-active --quiet ssh-tls.service || ! listening "$TLS_PORT"; then
    journalctl -u ssh-tls.service -n 30 --no-pager || true
    fail 'stunnel did not start or TCP 443 is not listening.'
fi

log 'Testing TLS and SSH banner through stunnel'
# openssl is the TLS client here; unlike raw /dev/tcp it understands TLS.
if ! timeout 12 openssl s_client -quiet -connect "127.0.0.1:$TLS_PORT" \
        -servername ssh-tunnel -CAfile "$CERT" -verify_return_error \
        </dev/null 2>/dev/null | grep -m1 -q '^SSH-2.0-'; then
    journalctl -u ssh-tls.service -n 20 --no-pager || true
    fail 'SSH banner was not received through verified TLS.'
fi

COMPLETE=1
log 'SUCCESS: SSH over TLS is running'
echo "SSH backend: 127.0.0.1:$SSH_PORT"
echo "TLS endpoint: TCP $TLS_PORT"
echo "Copy this public certificate to Windows: $CERT"
echo 'Do NOT copy ssh-tls.key or ssh-tls.pem to Windows.'
echo "Configuration backup: $BACKUP"
ss -lntp "sport = :$SSH_PORT or sport = :$TLS_PORT" || true
echo 'Verify an external connection before closing the VPS console.'
