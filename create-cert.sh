location=$(timedatectl show |grep Timezone| cut -d "/" -f 2) > /dev/null 2>&1

COUNTRY=$(curl https://ipinfo.io/|grep country|cut -d ":" -f 2 > ~/registry/certs/country.txt;cat ~/registry/certs/country.txt |cut -d "\"" -f 2) > /dev/null 2>&1
STATE=$(curl https://ipinfo.io/|grep region|cut -d ":" -f 2 > ~/registry/certs/region.txt;cat ~/registry/certs/region.txt |cut -d "\"" -f 2) > /dev/null 2>&1

export host_FQDN=$(hostname -f)

export wild_card=$(echo $host_FQDN|cut -d "." -f2-)


echo "Checking FQDN in Root CA $host_FQDN"
echo "Checking wild_card in Root CA $wild_card"


sleep 5

echo "For how long this rootCA should be valid? (in days)"
read valid_days

cat << EOF |tee ~/registry/certs/san.cnf
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = *$wild_card
EOF

####################################
## Step 1 - Certificate Authority ##
####################################
# Step 1.1 - Generate the Certificate Authority (CA) Private Key
openssl genrsa -out  ~/registry/certs/rootCA.key 2048
#echo "Creating CA Certificate"
# Step 1.2 - Generate the Certificate Authority Certificate
openssl req -x509 -new -nodes -key ~/registry/certs/rootCA.key -subj "/C=$COUNTRY/ST=$STATE/L=$location/O=Quay/OU=Docs/CN=Pi Lab Root CA"  -sha256 -days $valid_days -out ~/registry/certs/rootCA.cert



echo "For how long this Client cert should be valid? (in days)"
read valid_days


export host_cert=$(echo $host_FQDN|cut -d "." -f 1)
echo "Host_cert is: $host_cert"
echo $host_FQDN
sleep 5

#######################################
## Step 2: Quay Operator Certificate ##
#######################################
# Step 2.1 - Generate the Quay Operator Certificate Private Key
openssl genrsa -out ~/registry/certs/$host_cert.key 2048
# Step 2.2 - Generate the Quay Operator Certificate Signing Request
openssl req -new -key  ~/registry/certs/$host_cert.key -out ~/registry/certs/$host_cert.csr -subj "/C=$COUNTRY/ST=$STATE/L=$location/O=Quay/OU=Docs/CN=$host_FQDN"
#echo "Creating Quay Operator Certificate"
# Step 2.3 - Generate the Quay Operator Certificate
openssl x509 -req -in ~/registry/certs/$host_cert.csr -CA ~/registry/certs/rootCA.cert -CAkey ~/registry/certs/rootCA.key -CAcreateserial -out ~/registry/certs/$host_cert.cert -days $valid_days  -extensions v3_req -extfile ~/registry/certs/san.cnf

