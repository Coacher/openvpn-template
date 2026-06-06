#!/usr/bin/bash
openssl req \
    -x509 -newkey ed25519 -noenc -days 3650 \
    -keyout private.key -out public.crt \
    -subj "/CN=Server" \
    -addext "basicConstraints=CA:FALSE" \
    -addext "keyUsage=critical,digitalSignature" \
    -addext "extendedKeyUsage=clientAuth" \
    > /dev/null 2>&1
