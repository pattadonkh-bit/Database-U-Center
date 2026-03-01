FROM php:8.2-apache

RUN apt-get update && apt-get install -y libaio1t64 unzip wget\
    libaio1 \
    unzip \
    wget

WORKDIR /opt/oracle

RUN wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linux.x64-21.9.0.0.0dbru.zip \
    && unzip instantclient-basiclite-linux.x64-21.9.0.0.0dbru.zip \
    && rm instantclient-basiclite-linux.x64-21.9.0.0.0dbru.zip

ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_21_9

RUN docker-php-ext-configure oci8 --with-oci8=instantclient,/opt/oracle/instantclient_21_9 \
    && docker-php-ext-install oci8

WORKDIR /var/www/html