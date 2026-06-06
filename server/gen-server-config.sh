#!/usr/bin/bash

HOSTNAME="$(hostname --short)"
CLIENT_HASH="$(openssl x509 -fingerprint -sha256 -in ../client/public.crt -noout | cut -d '=' -f 2)"

sed -i \
    -e "s/<HOSTNAME>/${HOSTNAME}/" \
    -e "/<peer-fingerprint>/a ${CLIENT_HASH}" \
    "${1}"
