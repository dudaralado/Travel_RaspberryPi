podman volume prune
rm -rf ~/registry
# Create the base directory with:
mkdir ~/registry

#Create the two subdirectories with:
mkdir ~/registry/certs
mkdir ~/registry/auth

#Change in the certs directory with:
cd ~/registry/certs

cd ~/registry/auth

sh ~/RaspberryPi/create-cert.sh

#How to deploy the registry server
##It’s now time to deploy the registry server. Change back to the base registry directory with:
cd ~/registry

#Deploy the registry container with the command:

podman run -d \
--hostname raspv5.travel.io \
--restart=always \
--name registry \
-v ~/registry/certs:/certs \
-v ~/registry/certs:/certs \
-e REGISTRY_HTTP_ADDR=0.0.0.0:5000 \
-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/raspv5.cert \
-e REGISTRY_HTTP_TLS_KEY=/certs/raspv5.key \
-p 443:5000 \
registry:latest


#-v ~/registry/auth:/auth \
#-e REGISTRY_AUTH=htpasswd \
#-e REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm" \
#-e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
