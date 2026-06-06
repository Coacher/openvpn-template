#!/usr/bin/bash
openvpn --genkey tls-crypt "tls-crypt-$(hostname --short).key"
