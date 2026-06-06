#!/usr/bin/bash
openssl req \
    -x509 -newkey ed25519 -noenc -days 3650 -subj "/CN=common-name" \
    -keyout private.key -out public.crt > /dev/null 2>&1
