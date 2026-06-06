#!/usr/bin/bash

IP="$(ip route get 1 | grep -oP 'src \K\S+')"

cat > "$(hostname --short)-$(basename "${1}" .conf).ovpn" <<- EOF
$(sed -e "s/<IP>/${IP}/" "${1}")

<cert>
$(awk '/BEGIN/,/END/' public.crt)
</cert>

<key>
$(awk '/BEGIN/,/END/' private.key)
</key>

<tls-crypt>
$(awk '/BEGIN/,/END/' "../server/tls-crypt-$(hostname --short).key")
</tls-crypt>

<peer-fingerprint>
$(openssl x509 -fingerprint -sha256 -in ../server/public.crt -noout | cut -d '=' -f 2)
</peer-fingerprint>
EOF
