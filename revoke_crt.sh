#!/bin/bash

_CRT_PATH=${1}
if [ -z ${_CRT_PATH} ]; then
  exit 1
fi
_ABS_CRT_PATH="$(readlink -f ${_CRT_PATH})"

cd "$(dirname $(readlink -f $0))/"
source 'config.sh'

openssl ca -config "${CA_CONF}" -gencrl -revoke "${_ABS_CRT_PATH}"
