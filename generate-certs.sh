#!/bin/bash

CERT_DIR=./etc/infrastructure/nginx/certs
DOMAIN_NAME=magento.devel
mkdir -p $CERT_DIR
touch $CERT_DIR/nginx.conf
openssl genrsa -out $CERT_DIR/nginx.key 2048

cat > $CERT_DIR/nginx.conf <<EOF
[req]
default_bits = 2048
default_keyfile = nginx.key
distinguished_name = req_distinguished_name
req_extensions = req_ext
x509_extensions = v3_ca

[req_distinguished_name]
countryName = us
countryName_default = US
stateOrProvinceName = New York
stateOrProvinceName_default = New York
localityName = New York
localityName_default = Rochester
organizationName = uetiko
organizationName_default = uetiko
organizationalUnitName = Development
organizationalUnitName_default = Development
commonName = $DOMAIN_NAME
commonName_default = $DOMAIN_NAME
commonName_max = 64

[req_ext]
subjectAltName = @alt_names

[v3_ca]
subjectAltName = @alt_names

[alt_names]
DNS.1 = $DOMAIN_NAME
DNS.2 = 127.0.0.1
EOF

openssl req -new -sha256 -key $CERT_DIR/nginx.key -out $CERT_DIR/nginx.csr -config $CERT_DIR/nginx.conf
openssl x509 -req -in $CERT_DIR/nginx.csr -signkey $CERT_DIR/nginx.key -out $CERT_DIR/nginx.crt -days 365
rm $CERT_DIR/nginx.conf $CERT_DIR/nginx.csr
chmod 600 $CERT_DIR/nginx.key