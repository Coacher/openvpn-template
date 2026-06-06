#!/usr/bin/bash

sed -i -e "s/<HOSTNAME>/$(hostname --short)/" "${1}"
