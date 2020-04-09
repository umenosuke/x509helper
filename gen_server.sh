#!/bin/bash

cd "$(dirname $(readlink -f $0))/"
source 'config.sh'

SERVER_NAME=${1}
if [ -z ${SERVER_NAME} ]; then
  echo 'missing server name'
  exit 1
fi

subjectAltName=${2}
if [ -z ${subjectAltName} ]; then
  echo 'missing SAN'
  exit 1
fi

SERVER_PRIVATE="${WORK_DIR}"'/server_'"${SERVER_NAME}"'.pem'
SERVER_CSR="${WORK_DIR}"'/server_'"${SERVER_NAME}"'.csr'
SERVER_CERT="${WORK_DIR}"'/server_'"${SERVER_NAME}"'.crt'

SERVER_CONF="${WORK_DIR}"'/server_'"${SERVER_NAME}"'_openssl.cnf'
SERVER_x509_EXT="${WORK_DIR}"'/server_'"${SERVER_NAME}"'_x509.ext'

if [ ! -e "${SERVER_PRIVATE}" ]; then
  openssl genrsa -out "${SERVER_PRIVATE}" "${SERVER_PRIVATE_SIZE}"
fi

SERVER_SUBJECT='/C='"${SERVER_SUBJECT_countryName}"'/ST='"${SERVER_SUBJECT_stateOrProvinceName}"'/L='"${SERVER_SUBJECT_L}"'/O='"${SERVER_SUBJECT_organizationName}"'/OU='"${SERVER_SUBJECT_organizationalUnitName}"'/CN='"${SERVER_NAME}"'/emailAddress='"${SERVER_SUBJECT_emailAddress}"
echo ${SERVER_SUBJECT}

cp /etc/pki/tls/openssl.cnf "${SERVER_CONF}"
echo -e "\n[ SAN ]\nsubjectAltName = ${subjectAltName}\n" >> "${SERVER_CONF}"
openssl req -new -config "${SERVER_CONF}" -reqexts SAN -key "${SERVER_PRIVATE}" -out "${SERVER_CSR}" -sha256 -subj "${SERVER_SUBJECT}"

###########################################################################################################################################

cat << EOS >> "${SERVER_x509_EXT}"
subjectAltName="${subjectAltName}"
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
authorityKeyIdentifier=keyid,issuer
EOS

openssl ca -days "${SERVER_TTL}" \
  -extfile "${SERVER_x509_EXT}" \
  -in "${SERVER_CSR}" \
  -out "${SERVER_CERT}" \
  -notext

cat "${CA_CERT}" >> "${SERVER_CERT}"
