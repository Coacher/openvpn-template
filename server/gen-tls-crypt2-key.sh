#!/usr/bin/bash
openvpn --genkey tls-crypt-v2-server "tls-crypt2-server-$(hostname --short).key"
