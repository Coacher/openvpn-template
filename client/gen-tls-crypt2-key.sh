#!/usr/bin/bash
openvpn --tls-crypt-v2 "../server/tls-crypt2-server-$(hostname --short).key" \
    --genkey tls-crypt-v2-client "tls-crypt2-client-$(hostname --short).key"
