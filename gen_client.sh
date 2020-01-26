#!/bin/bash

cd $(dirname $0)
source 'config.sh'

CLIENT_NAME=${1}
if [ -z ${CLIENT_NAME} ]; then
  echo 'missing client name'
  exit 1
fi

CLIENT_PRIVATE="${WORK_DIR}"'/client_'"${CLIENT_NAME}"'.pem'
CLIENT_CSR="${WORK_DIR}"'/client_'"${CLIENT_NAME}"'.csr'
CLIENT_CERT="${WORK_DIR}"'/client_'"${CLIENT_NAME}"'.crt'

CLIENT_SUBJECT='/C='"${CLIENT_SUBJECT_countryName}"'/ST='"${CLIENT_SUBJECT_stateOrProvinceName}"'/L='"${CLIENT_SUBJECT_L}"'/O='"${CLIENT_SUBJECT_organizationName}"'/OU='"${CLIENT_SUBJECT_organizationalUnitName}"'/CN='"${CLIENT_NAME}"'/emailAddress='"${CLIENT_SUBJECT_emailAddress}"
echo ${CLIENT_SUBJECT}

CLIENT_x509_EXT="${WORK_DIR}"'/client_'"${CLIENT_NAME}"'_x509.ext'
CLIENT_P12="${WORK_DIR}"'/client_'"${CLIENT_NAME}"'.p12'

if [ ! -e "${CLIENT_PRIVATE}" ]; then
  openssl genrsa -out "${CLIENT_PRIVATE}" "${CLIENT_PRIVATE_SIZE}"
fi

openssl req -new -key "${CLIENT_PRIVATE}" -out "${CLIENT_CSR}" -subj "${CLIENT_SUBJECT}"

###########################################################################################################################################

cat << "EOS" >> "${CLIENT_x509_EXT}"
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth
authorityKeyIdentifier=keyid,issuer
EOS

openssl ca -days "${CLIENT_TTL}" \
  -extfile "${CLIENT_x509_EXT}" \
  -in "${CLIENT_CSR}" \
  -out "${CLIENT_CERT}"

openssl pkcs12 -export -clcerts \
  -inkey "${CLIENT_PRIVATE}" \
  -in "${CLIENT_CERT}" \
  -out "${CLIENT_P12}" \
  -passout pass:
