# docker-powerdns-certbot
Let's Encrypt DNS challenge with PowerDNS.

## Configuration options

See [Dockerfile](Dockerfile#L12)

### CAA record
Since Let’s Encrypt checks CAA records before every certificate we issue, sometimes we get errors even for domains that haven’t set any CAA records.

If you want to generate a certificate for your domain name, make sure that the "CAA" registration is present on the DNS server. Otherwise it will have to be added:
```
example.com. CAA 0 issue "letsencrypt.org"
```


## How to use

### Create certificates

```
docker run \
    --rm \
    -e "PDNS_API_KEY=XXXXX" \
    -e "PDNS_API_URL=http://localhost:8081/api/v1" \
    -v /docker/letsencrypt:/etc/letsencrypt \
    -t aasaidane/powerdns-certbot \
    create -m postmaster@example.com -d example.com -d www.example.com
```

### Renew certificates

```
docker run \
    --rm \
    -v /docker/letsencrypt:/etc/letsencrypt \
    -t aasaidane/powerdns-certbot \
    renew
```

### Certbot

```
docker run \
    --rm \
    -v /docker/letsencrypt:/etc/letsencrypt \
    -t aasaidane/powerdns-certbot \
    certbot --agree-tos --text --authenticator certbot-pdns:auth --renew-by-default certonly -n -m postmaster@example.com -d example.com -d www.example.com
```