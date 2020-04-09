#!/bin/bash

_CLIENT_CRT=${1}
if [ -z ${_CLIENT_CRT} ]; then
  exit 1
fi
_ABS_CLIENT_CRT="$(readlink -f ${_CLIENT_CRT})"

cd "$(dirname $(readlink -f $0))/"
_BASE_DIR="$(pwd)"

cat "${_ABS_CLIENT_CRT}" | openssl x509 -noout -text | less
