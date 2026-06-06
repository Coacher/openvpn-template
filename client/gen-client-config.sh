#!/usr/bin/bash

IP="$(ip route get 1 | grep -oP 'src \K\S+')"

cat > "$(hostname --short)-$(basename "${1}" .conf).ovpn" <<- EOF
$(sed -e "s/<IP>/${IP}/g" "${1}")

<ca>
$(awk '/BEGIN/,/END/' ca.crt)
</ca>

<cert>
$(awk '/BEGIN/,/END/' public.crt)
</cert>

<key>
$(awk '/BEGIN/,/END/' private.key)
</key>

<tls-crypt>
$(awk '/BEGIN/,/END/' "../server/tls-crypt-$(hostname --short).key")
</tls-crypt>
EOF
