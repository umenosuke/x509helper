#!/bin/bash

_CRT_PATH=${1}
if [ -z ${_CRT_PATH} ]; then
  exit 1
fi
_ABS_CRT_PATH="$(readlink -f ${_CRT_PATH})"

cd "$(dirname $(readlink -f $0))/"
_BASE_DIR="$(pwd)"

cat "${_ABS_CRT_PATH}" | openssl x509 -noout -text | less
