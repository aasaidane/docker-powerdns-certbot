FROM debian:stretch

MAINTAINER SAIDANE Ahmed Amine <https://github.com/aasaidane/>

# Environment variables
#######################

ENV DATA_DIR /etc/letsencrypt
ENV DEBIAN_FRONTEND noninteractive


# Configurable environment variables
####################################

# PowerDNS API Key.
# See https://doc.powerdns.com/md/authoritative/settings/#api-key
ENV PDNS_API_KEY ""

# PowerDNS API Url.
ENV PDNS_API_URL ""


# Install required packages
##############################
RUN apt-get update
RUN apt-get install -y git python-pip

# Install Certbot
#################################
RUN pip2 install -U certbot


# Install Certbot PDNS plugin
#################################
RUN pip2 install certbot-pdns

#install from sources
#RUN cd /opt
#RUN git clone https://github.com/robin-thoni/certbot-pdns.git certbot-pdns
#cd /opt/certbot-pdns
#RUN python2 setup.py install


# Create Volume
########################
RUN mkdir -p $DATA_DIR
VOLUME $DATA_DIR


# Copy scripts
#######################
ADD script/entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh


# Set the entry point
#######################
ENTRYPOINT ["/docker-entrypoint.sh"]