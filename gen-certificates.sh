#!/usr/bin/bash

WORK=$(mktemp -d)
trap 'rm -rf "${WORK}"' EXIT

openssl genpkey -algorithm ED25519 -out "${WORK}/ca.key"
openssl req -new -x509 -days 3650 \
    -key "${WORK}/ca.key" \
    -out "${WORK}/ca.crt" \
    -subj "/CN=CA" \
    -addext "basicConstraints=critical,CA:TRUE,pathlen:1" \
    -addext "keyUsage=critical,keyCertSign,cRLSign" \
    -addext "subjectKeyIdentifier=hash"

openssl genpkey -algorithm ED25519 -out server/private.key
openssl req -new \
    -key server/private.key \
    -subj "/CN=Server" \
    -addext "basicConstraints=critical,CA:FALSE" \
    -addext "keyUsage=critical,digitalSignature" \
    -addext "extendedKeyUsage=serverAuth" \
    -addext "subjectKeyIdentifier=hash" \
    -addext "subjectAltName=DNS:server" |
openssl x509 -req -days 3650 \
    -CA "${WORK}/ca.crt" \
    -CAkey "${WORK}/ca.key" \
    -CAcreateserial \
    -copy_extensions copy \
    -out server/public.crt

openssl genpkey -algorithm ED25519 -out client/private.key
openssl req -new \
    -key client/private.key \
    -subj "/CN=Client" \
    -addext "basicConstraints=critical,CA:FALSE" \
    -addext "keyUsage=critical,digitalSignature" \
    -addext "extendedKeyUsage=clientAuth" \
    -addext "subjectKeyIdentifier=hash" \
    -addext "subjectAltName=DNS:client" |
openssl x509 -req -days 3650 \
    -CA "${WORK}/ca.crt" \
    -CAkey "${WORK}/ca.key" \
    -CAcreateserial \
    -copy_extensions copy \
    -out client/public.crt

chmod 400 server/private.key client/private.key

cp "${WORK}/ca.crt" server/
cp "${WORK}/ca.crt" client/
