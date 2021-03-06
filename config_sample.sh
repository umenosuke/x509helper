WORK_DIR=./work

CA_PRIVATE="${WORK_DIR}"'/ca.pem'
CA_CERT="${WORK_DIR}"'/ca.crt'

#CA_CRL="${WORK_DIR}"'/ca.crl'
CA_SERIAL='/etc/pki/CA/serial'
CA_INDEX='/etc/pki/CA/index.txt'
CA_CRL_NUM='/etc/pki/CA/crlnumber'
CA_CONF="${WORK_DIR}"'/ca_openssl.cnf'

CA_TTL='3650'
CA_PRIVATE_SIZE='15360'
CA_SUBJECT_countryName='JP'
CA_SUBJECT_stateOrProvinceName='hogehoge'
CA_SUBJECT_L='hogehoge'
CA_SUBJECT_organizationName='hogehoge'
CA_SUBJECT_organizationalUnitName='dev'
CA_SUBJECT_commonName='example.com'
CA_SUBJECT_emailAddress='example@example.com'

SERVER_TTL='3650'
SERVER_PRIVATE_SIZE='8192'
SERVER_SUBJECT_countryName='JP'
SERVER_SUBJECT_stateOrProvinceName='hogehoge'
SERVER_SUBJECT_L='hogehoge'
SERVER_SUBJECT_organizationName='hogehoge'
SERVER_SUBJECT_organizationalUnitName='dev'
SERVER_SUBJECT_emailAddress='example@example.com'

CLIENT_TTL='3650'
CLIENT_PRIVATE_SIZE='4096'
CLIENT_SUBJECT_countryName='JP'
CLIENT_SUBJECT_stateOrProvinceName='hogehoge'
CLIENT_SUBJECT_L='hogehoge'
CLIENT_SUBJECT_organizationName='hogehoge'
CLIENT_SUBJECT_organizationalUnitName='dev'
CLIENT_SUBJECT_emailAddress='example@example.com'
