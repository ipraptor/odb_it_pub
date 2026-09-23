#!/usr/bin/env bash
# Ubuntu: TLS wrapper on TCP/443 for an EXISTING, WORKING SSH on TCP/22.
# Does not change sshd_config, ssh.socket, firewall, or running SSH sessions.
set -Eeuo pipefail

PORT=443
SSH_PORT=22
CONF=/etc/stunnel/ssh-tls.conf
CERT=/etc/stunnel/ssh-tls.crt
KEY=/etc/stunnel/ssh-tls.key
SERVICE=/etc/systemd/system/ssh-tls.service
LOG=/var/log/ssh-tls-setup.log

if (( EUID != 0 )); then echo 'Run: sudo bash setup-ssh-tls-fixed.sh' >&2; exit 1; fi
exec > >(tee -a "$LOG") 2>&1
trap 'echo "ERROR at line $LINENO. See $LOG" >&2' ERR
say() { printf '\n== %s ==\n' "$*"; }
die() { echo "ERROR: $*" >&2; exit 1; }

say '1/6: Verify that SSH on 127.0.0.1:22 actually answers'
# An existing listening socket alone is not sufficient; verify the banner.
# This check changes nothing on the server.
ssh_banner=$(timeout 7 bash -c 'exec 3<>/dev/tcp/127.0.0.1/22; IFS= read -r -t 5 line <&3; printf "%s" "$line"' 2>/dev/null || true)
[[ "$ssh_banner" == SSH-2.0-* ]] || die 'Local SSH at 127.0.0.1:22 did not return an SSH-2.0 banner. SSH settings were NOT changed. Check: sudo ss -lntp | grep :22'
echo "OK: $ssh_banner"

say '2/6: Check whether TCP/443 is available'
# If a previous run of THIS unit has already configured 443, it is safe to
# stop that unit and replace its configuration. Never stop ssh/ssh.socket.
if systemctl is-active --quiet ssh-tls.service 2>/dev/null; then
  echo 'Stopping the previous ssh-tls.service instance (SSH is untouched).'
  systemctl stop ssh-tls.service
fi
if ss -H -lnt "( sport = :$PORT )" | grep -q .; then
  ss -lntp "( sport = :$PORT )" || true
  die 'TCP/443 is occupied. If the listener is SSH, first free 443 using your existing ssh.socket setup; this script will NOT touch SSH.'
fi

say '3/6: Install stunnel and openssl'
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y stunnel4 openssl
STUNNEL_BIN=$(command -v stunnel4 || true)
[[ -n "$STUNNEL_BIN" ]] || die 'Cannot find stunnel4 executable.'

say '4/6: Create or reuse certificate and config'
install -d -m 700 /etc/stunnel
if [[ -e "$CERT" || -e "$KEY" ]]; then
  [[ -s "$CERT" && -s "$KEY" ]] || die 'Only one TLS key/certificate file exists. No keys were overwritten; inspect /etc/stunnel/ssh-tls.{key,crt}.'
  openssl x509 -in "$CERT" -noout >/dev/null || die 'Existing certificate is invalid.'
  openssl pkey -in "$KEY" -noout >/dev/null || die 'Existing TLS private key is invalid.'
  cert_pub=$(openssl x509 -in "$CERT" -pubkey -noout | openssl pkey -pubin -outform DER | openssl dgst -sha256)
  key_pub=$(openssl pkey -in "$KEY" -pubout -outform DER | openssl dgst -sha256)
  [[ "$cert_pub" == "$key_pub" ]] || die 'Existing TLS certificate and key do not match.'
  echo 'Reusing the existing TLS certificate and key.'
else
  openssl req -x509 -newkey rsa:3072 -sha256 -nodes -days 365 \
    -keyout "$KEY" -out "$CERT" \
    -subj '/CN=ssh-tunnel' -addext 'subjectAltName=DNS:ssh-tunnel'
  echo 'Created a self-signed certificate with DNS SAN ssh-tunnel.'
fi
chmod 600 "$KEY"
chmod 644 "$CERT"
cat > "$CONF" <<EOF
client = no
foreground = yes
sslVersionMin = TLSv1.2
cert = $CERT
key = $KEY

[ssh]
accept = 0.0.0.0:$PORT
connect = 127.0.0.1:$SSH_PORT
EOF
chmod 600 "$CONF"
cat > "$SERVICE" <<EOF
[Unit]
Description=TLS wrapper for existing SSH (TCP 443 -> 127.0.0.1:22)
After=network.target

[Service]
Type=simple
ExecStart=$STUNNEL_BIN $CONF
Restart=on-failure
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

say '5/6: Start the dedicated service (no PID file and no SSH restart)'
systemctl daemon-reload
systemctl enable --now ssh-tls.service
sleep 2
if ! systemctl is-active --quiet ssh-tls.service; then
  systemctl status ssh-tls.service --no-pager -l || true
  journalctl -u ssh-tls.service -n 30 --no-pager || true
  die 'Stunnel service did not stay active; SSH on 22 was not modified.'
fi
if ! ss -H -lnt "( sport = :$PORT )" | grep -q .; then
  journalctl -u ssh-tls.service -n 30 --no-pager || true
  die 'Service is running but nothing listens on 443.'
fi

say '6/6: Test TLS handshake against localhost:443'
# openssl s_client validates TLS independently of SSH. We do not assert that
# the outside network/firewall works: that must be tested from Windows.
tls_output=$(timeout 12 openssl s_client -connect 127.0.0.1:443 \
  -servername ssh-tunnel -CAfile "$CERT" \
  -verify_hostname ssh-tunnel -verify_return_error -brief </dev/null 2>&1) || {
  echo "$tls_output"
  die 'Local TLS handshake or certificate verification failed.'
}
echo "$tls_output" | grep -q 'Verification: OK' || {
  echo "$tls_output"
  die 'TLS handshake completed but certificate verification did not report OK.'
}
printf '\nSUCCESS: SSH on 127.0.0.1:22 is unchanged; Stunnel listens on TCP/443.\n'
printf 'Copy this PUBLIC certificate to Windows: %s\n' "$CERT"
printf 'Do NOT copy the private key: %s\n' "$KEY"
printf 'Check externally: connect with the Windows Stunnel client to SERVER_IP:443.\n'
printf 'If port 443 is blocked by UFW or a hosting firewall, allow it separately.\n'
printf 'Diagnostic log: %s\n' "$LOG"
