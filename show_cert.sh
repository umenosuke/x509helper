#!/bin/bash

cd $(dirname $0)

CLIENT_CRT=${1}
if [ -z ${CLIENT_CRT} ]; then
  exit 1
fi

cat "${CLIENT_CRT}" | openssl x509 -noout -text | less
