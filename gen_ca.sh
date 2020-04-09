#!/bin/bash

cd "$(dirname $(readlink -f $0))/"
source 'config.sh'

mkdir -p ${WORK_DIR}

if [ ! -e "${CA_INDEX}" ]; then
  touch "${CA_INDEX}"
  chmod 600 "${CA_INDEX}"
fi

if [ ! -e "${CA_SERIAL}" ]; then
  echo '1000' > "${CA_SERIAL}"
  chmod 600 "${CA_SERIAL}"
fi

if [ ! -e "${CA_CRL_NUM}" ]; then
  cp "${CA_SERIAL}" "${CA_CRL_NUM}"
  chmod 600 "${CA_CRL_NUM}"
fi

if [ ! -e "${CA_PRIVATE}" ]; then
  openssl genrsa -out "${CA_PRIVATE}" "${CA_PRIVATE_SIZE}"
fi

CA_SUBJECT='/C='"${CA_SUBJECT_countryName}"'/ST='"${CA_SUBJECT_stateOrProvinceName}"'/L='"${CA_SUBJECT_L}"'/O='"${CA_SUBJECT_organizationName}"'/OU='"${CA_SUBJECT_organizationalUnitName}"'/CN='"${CA_SUBJECT_commonName}"'/emailAddress='"${CA_SUBJECT_emailAddress}"
echo ${CA_SUBJECT}

cp /etc/pki/tls/openssl.cnf "${CA_CONF}"
openssl req -new -config "${CA_CONF}" -x509 -days "${CA_TTL}" -key "${CA_PRIVATE}" -out "${CA_CERT}" -subj "${CA_SUBJECT}"

cp "${CA_CERT}" /etc/pki/CA/cacert.pem
cp "${CA_PRIVATE}" /etc/pki/CA/private/cakey.pem
