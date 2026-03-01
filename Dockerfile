FROM php:8.2-apache

# ติดตั้ง dependency
RUN apt-get update && apt-get install -y \
    libaio1t64 \
    unzip \
    wget

# ดาวน์โหลด Oracle Instant Client
WORKDIR /opt/oracle

RUN wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linux.x64-21.13.0.0.0dbru.zip && \
    unzip instantclient-basiclite-linux.x64-21.13.0.0.0dbru.zip && \
    rm instantclient-basiclite-linux.x64-21.13.0.0.0dbru.zip

# ตั้งค่า environment
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_21_13

# ติดตั้ง OCI8 extension
RUN echo "instantclient,/opt/oracle/instantclient_21_13" | pecl install oci8 && \
    docker-php-ext-enable oci8

WORKDIR /var/www/html