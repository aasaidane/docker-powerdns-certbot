#!/bin/bash
CONFIG_FILE="/etc/letsencrypt/certbot-pdns.json"

if [ ! -f $CONFIG_FILE ] ; then
    echo "{\"api-key\": \"API_KEY\",\"base-url\": \"API_URL\",\"axfr-time\": 5}" > ${CONFIG_FILE}
fi

if [ ! -z $PDNS_API_KEY ] ; then
    #sed -i s/API_KEY/${PDNS_API_KEY}/ ${CONFIG_FILE}
    sed -i 's@API_KEY@'"$PDNS_API_KEY"'@g' ''"$CONFIG_FILE"''
fi
if [ ! -z $PDNS_API_KEY ] ; then
    #sed -i s/API_URL/${PDNS_API_URL}/ ${CONFIG_FILE}
    sed -i 's@API_URL@'"$PDNS_API_URL"'@g' ''"$CONFIG_FILE"''
fi

cmd=$1;
shift

if [ "$cmd" = 'create' ]; then
    #-m postmaster@example.com -d example.com -d www.example.com
    certbot --agree-tos --text --authenticator certbot-pdns:auth --renew-by-default certonly -n $@
elif [ "$cmd" = 'renew' ]; then
    certbot --agree-tos --text --authenticator certbot-pdns:auth renew -n
elif [ "$cmd" = 'certbot' ]; then
    certbot $@
fi

exit 0;
