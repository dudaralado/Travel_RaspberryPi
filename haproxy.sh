cat << EOF| sudo tee /etc/haproxy/haproxy.cfg
global
        log /dev/log    local0
        log /dev/log    local1 notice
        chroot /var/lib/haproxy
        stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
        stats timeout 30s
        user haproxy
        group haproxy
        daemon

        # Default SSL material locations
        ca-base /etc/ssl/certs
        crt-base /etc/ssl/private

        # See: https://ssl-config.mozilla.org/#server=haproxy&server-version=2.0.3&config=intermediate
        ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
        ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
        ssl-default-bind-options ssl-min-ver TLSv1.2 no-tls-tickets

defaults
        log     global
        mode    http
        option  httplog
        option  dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
        errorfile 400 /etc/haproxy/errors/400.http
        errorfile 403 /etc/haproxy/errors/403.http
        errorfile 408 /etc/haproxy/errors/408.http
        errorfile 500 /etc/haproxy/errors/500.http
        errorfile 502 /etc/haproxy/errors/502.http
        errorfile 503 /etc/haproxy/errors/503.http
        errorfile 504 /etc/haproxy/errors/504.http



  option                  dontlognull
  option http-server-close
  option                  redispatch
  retries                 3
  timeout http-request    10s
  timeout queue           1m
  timeout connect         10s
  timeout http-keep-alive 10s
  timeout check           10s
  maxconn                 3000

resolvers mydns
    nameserver pve 172.16.10.1:53


    #---------------------------------------------------------------------
    # main frontend which proxys to the backends
    #---------------------------------------------------------------------
    frontend stats
      bind *:1936
      mode            http
      log             global
      maxconn 10
      stats enable
      stats hide-version
      stats refresh 30s
      stats show-node
      stats show-desc Stats for ocp4 cluster
      stats auth admin:ocp4
      stats uri /stats

    #---------------------------------------------------------------------
    # round robin balancing between the various backends K8S
    #---------------------------------------------------------------------
# 
# HTTP Load Balancer for Ingress (Port 80)
    listen ingress-http-80
      bind *:80
      mode tcp
      balance source
      server kubernetes.nuc.lab 192.168.0.143:80 check inter 1s

# HTTPS Load Balancer for Ingress (Port 443)
    listen ingress-https-443
      bind *:443
      mode tcp
      balance source
      server kubernetes.nuc.lab 192.168.0.143:443 check inter 1s

# HTTPS Load Balancer for Ingress (Port 6443)
    listen ingress-https-6443
      bind *:6443
      mode tcp
      balance source
      server kubernetes.nuc.lab 192.168.0.143:6443 check inter 1s
EOF
